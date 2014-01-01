#
# Cookbook Name:: railstutorial
# Recipe:: railssetup
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

%w{libxslt-devel libxml2-devel sqlite-devel}.each do |pkg|
    package pkg do
        action :install
    end
end

