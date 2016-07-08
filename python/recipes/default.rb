#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if platform?('ubuntu')
  package %w[build-essential]
else
  package %w[openssl-devel]
end

remote_file '/tmp/Python-3.4.4.tgz' do
  source 'https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz'

  notifies :run, 'execute[extract python]', :immediately
end

execute 'extract python' do
  command 'tar xzf /tmp/Python-3.4.4.tgz'
  cwd '/tmp'
  action :nothing
  notifies :run, 'execute[python build and install]', :immediately
end

execute 'python build and install' do
  command './configure && make install'
  cwd '/tmp/Python-3.4.4'
  action :nothing
end
