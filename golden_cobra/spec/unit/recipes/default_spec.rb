#
# Cookbook Name:: golden_cobra
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'golden_cobra::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node,server|
        # TODO stub the site data on the server
      end
      runner.converge(described_recipe)
    end

    it 'updates the package caches' do
      expect(chef_run).to run_execute('yum update -y')
    end

    it 'installs database packages' do
      expect(chef_run).to install_package('sqlite-devel')
    end

    it 'installs python' do
      expect(chef_run).to include_recipe('python')
    end

    it 'installs django' do
      expect(chef_run).to install_pip('django')
    end

    it 'installs uwsgi' do
      expect(chef_run).to install_pip('uwsgi')
    end

    it 'installs gunicorn' do
      expect(chef_run).to install_pip('gunicorn')
    end

    it 'creates a directory for sites' do
      expect(chef_run).to create_directory('/sites')
    end

    it 'installs git' do
      expect(chef_run).to install_package('git')
    end

    it 'creates all the defined sites' do
      expect(chef_run).to sync_git('/sites/golden_cobra').with(repository: 'https://github.com/burtlo/golden_cobra.git')
      expect(chef_run).to run_execute('/usr/local/bin/python3 manage.py migrate').with(cwd: '/sites/golden_cobra')
      expect(chef_run).to run_execute('gunicorn golden_cobra.wsgi -D -b 127.0.0.1:8000').with(cwd: '/sites/golden_cobra')
    end
  end
end
