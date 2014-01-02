#
# Cookbook Name:: railstutorial
# Recipe:: railssetup
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

%w{git libxslt-devel libxml2-devel sqlite-devel}.each do |pkg|
    package pkg do
        action :install
    end
end

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:rbenv][:ruby][:version] do
  ruby_version node[:rbenv][:ruby][:version]
  global true
end

%w{bundler execjs}.each do |g|
  gem_package g do
    action :install
  end
end

