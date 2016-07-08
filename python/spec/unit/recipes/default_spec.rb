#
# Cookbook Name:: python
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'python::default' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(node_attributes)
    runner.converge(described_recipe)
  end

  let(:node_attributes) do
    {}
  end

  context 'When all attributes are default, on an unspecified platform' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the necessary packages' do
      expect(chef_run).to install_package(%w[openssl-devel])
    end

    it 'installs python 3.4.4' do
      expect(chef_run).to install_with_make_ark('python').with({
        version: '3.4.4',
        url: 'https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz'
      })
    end
  end

  context 'When all attributes are default, on ubuntu' do
    let(:node_attributes) do
      { platform: 'ubuntu', version: '14.04' }
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the necessary packages' do
      expect(chef_run).to install_package(%w[build-essential])
    end
  end

end
