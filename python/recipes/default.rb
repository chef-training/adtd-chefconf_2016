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

ark 'python' do
  version '3.4.4'
  url 'https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz'
  action :install_with_make
end
