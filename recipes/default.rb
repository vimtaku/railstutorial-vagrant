#
# Cookbook Name:: railstutorial
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

group "#{node['rails']['group']}"

user "#{node['rails']['group']}" do
  group "#{node['rails']['group']}"
  system true
  shell "/bin/bash"
end

# artifact_deploy "#{node['myface']['group']}" do
#   version "1.0.0"
#   artifact_location "/tmp/myface-1.0.0.tar.gz"
#   deploy_to "/srv/myface"
#   owner "#{node['myface']['user']}"
#   group "#{node['myface']['group']}"
#   action :deploy
# end

