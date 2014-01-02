#
# Cookbook Name:: railstutorial
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::epel"

group "#{node['rails']['group']}"

user "#{node['rails']['user']}" do
  group "#{node['rails']['group']}"
  system true
  home "/home/#{node['rails']['user']}"
  supports :manage_home => true
  shell "/bin/bash"
end


directory "/srv/#{node[:rails][:name]}" do
  owner "#{node['rails']['user']}"
  group "#{node['rails']['group']}"
  action :create
end
directory "/srv/#{node[:rails][:name]}/shared" do
  owner "#{node['rails']['user']}"
  group "#{node['rails']['group']}"
  action :create
end

deploy "/srv/#{node[:rails][:name]}" do
  repo "https://github.com/vimtaku/railstutorial.git"
  deploy_to "/srv/#{node[:rails][:name]}"
  revision "HEAD"
  user "rails"
  enable_submodules false
  migrate false
  migration_command "rake db:migrate"
  environment "development"
  shallow_clone true
  action :deploy
  restart_command Proc.new {
    bash "name" do
      cwd "/srv/#{node[:rails][:name]}/current"
      ## bundle install の場所がいまいちだけど
      ## こっちの方が早いと思うしこっちでいく
      code %{
        echo "exec bundle install, this will take a long time...."
        bundle install
        touch tmp/restart.txt
        kill `ps aux | grep server | grep ruby | awk '{print $2}'` 2>/dev/null
        bundle exec rails server -d
      }
    end
  }

  symlink_before_migrate.clear
  #create_dirs_before_symlink ["tmp"]
  purge_before_symlink.clear
  symlinks.clear
end

