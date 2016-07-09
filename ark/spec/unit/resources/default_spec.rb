require 'spec_helper'

describe 'ark' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(node_attributes.merge(settings).merge(step_into))
    runner.converge(described_recipe)
    runner
  end

  # This is an empty hash that contains any possible node attributes. The reason
  # for defining at the top-level is to allow nested contexts redefine it with
  # what they need to get the job done.
  # what they need to get the job done.
  let(:node_attributes) do
    {}
  end

  # This is the location to place any ChefSpec global configuration/settings
  # @see https://github.com/sethvargo/chefspec#configuration
  let(:settings) do
    { file_cache_path: '/var/chef/cache' }
  end

  # This is required to test the internal components of a LWRP / Custom Resource
  # @see https://github.com/sethvargo/chefspec#testing-lwrps
  let(:step_into) do
    { step_into: ['ark'] }
  end

  describe 'install' do
    let(:described_recipe) { 'ark_spec::install' }

    it 'generates the expected resources with the expected actions and notifications' do
      expect(chef_run).to install_ark('test_install')

      expect(chef_run).to create_directory('/usr/local/test_install-2')
      resource = chef_run.directory('/usr/local/test_install-2')
      expect(resource).to notify('execute[unpack /var/chef/cache/test_install-2.tar.gz]').to(:run)

      expect(chef_run).to create_remote_file('/var/chef/cache/test_install-2.tar.gz')
      resource = chef_run.remote_file('/var/chef/cache/test_install-2.tar.gz')
      expect(resource).to notify('execute[unpack /var/chef/cache/test_install-2.tar.gz]').to(:run)

      expect(chef_run).not_to run_execute('unpack /var/chef/cache/test_install-2.tar.gz')
      resource = chef_run.execute('unpack /var/chef/cache/test_install-2.tar.gz')
      expect(resource).to notify('execute[set owner on /usr/local/test_install-2]').to(:run)

      expect(chef_run).not_to run_execute('set owner on /usr/local/test_install-2')

      expect(chef_run).to create_link('/usr/local/test_install')

      expect(chef_run).not_to create_template('/etc/profile.d/test_install.sh')
      expect(chef_run).not_to run_ruby_block('adding \'/usr/local/test_install-2/bin\' to chef-client ENV[\'PATH\']')
    end
  end

  describe 'install_with_make' do
    let(:described_recipe) { 'ark_spec::install_with_make' }
    it 'generates the expected resources with the expected actions and notifications'
  end

  describe 'install with binaries' do
    let(:described_recipe) { 'ark_spec::install_with_binaries' }
    it 'generates the expected resources with the expected actions and notifications'
  end

  # The following pending specifications are commented out so they do not generate
  # more output when running the current test suite.

  # describe 'install with append_env_path' do
  #   context 'binary is not already in the environment path' do
  #     let(:described_recipe) { 'ark_spec::install_with_append_env_path' }
  #     it 'generates the expected resources with the expected actions and notifications'
  #   end
  #
  #   context 'binary is already in the environment path' do
  #     let(:described_recipe) { 'ark_spec::install_with_append_env_path' }
  #
  #     # TODO: Using the ENV is terrible -- attempts to replace it with a helper
  #     #   method did not work or a class with a method. Explore different ways
  #     #   to inject the value instead of using this way.
  #
  #     before do
  #       @old_paths = ENV['PATH']
  #       ENV['PATH'] = '/usr/local/test_install_with_append_env_path-7.0.26/bin'
  #     end
  #
  #     after do
  #       ENV['PATH'] = @old_paths
  #     end
  #
  #     it 'generates the expected resources with the expected actions and notifications'
  #   end
  # end
  #
  # describe 'install on windows' do
  #   let(:described_recipe) { 'ark_spec::install_windows' }
  #
  #   let(:node_attributes) do
  #     { platform: 'windows', version: '2008R2' }
  #   end
  #
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'configure' do
  #   let(:described_recipe) { 'ark_spec::configure' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'put' do
  #   let(:described_recipe) { 'ark_spec::put' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'dump' do
  #   let(:described_recipe) { 'ark_spec::dump' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'unzip' do
  #   let(:described_recipe) { 'ark_spec::unzip' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'cherry_pick' do
  #   let(:described_recipe) { 'ark_spec::cherry_pick' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'setup_py_build' do
  #   let(:described_recipe) { 'ark_spec::setup_py_build' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'setup_py_install' do
  #   let(:described_recipe) { 'ark_spec::setup_py_install' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end
  #
  # describe 'setup_py' do
  #   let(:described_recipe) { 'ark_spec::setup_py' }
  #   it 'generates the expected resources with the expected actions and notifications'
  # end

end
