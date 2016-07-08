require 'spec_helper'

require 'spec_helper'

describe 'python' do
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
    { }
  end

  # This is required to test the internal components of a LWRP / Custom Resource
  # @see https://github.com/sethvargo/chefspec#testing-lwrps
  let(:step_into) do
    { step_into: ['pip'] }
  end

  describe 'install' do
    let(:described_recipe) { 'python_spec::pip_install' }

    it 'generates the expected resources with the expected actions' do
      expect(chef_run).to install_pip('django')
      expect(chef_run).to run_execute('/usr/local/bin/pip3 install django')
    end
  end
end
