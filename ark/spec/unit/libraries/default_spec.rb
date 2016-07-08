require 'spec_helper'
require_relative '../../../libraries/default'

describe Opscode::Ark::ProviderHelpers do
  class Subject
    include Opscode::Ark::ProviderHelpers
  end

  describe '#cherry_pick_tar_command' do
    let(:subject) do
      obj = Subject.new
      allow(obj).to receive(:node).and_return({ 'ark' => { 'tar' => '/bin/tar' } })
      allow(obj).to receive(:new_resource).and_return(new_resource)
      allow(obj).to receive(:tar_strip_args).and_return('')
      obj
    end

    let(:new_resource) do
      obj = double(:new_resource)
      allow(obj).to receive(:release_file).and_return('release-file')
      allow(obj).to receive(:path).and_return('path')
      allow(obj).to receive(:creates).and_return('creates')
      obj
    end

    let(:tar_args) { 'xvf' }

    let(:expected_result) { '/bin/tar xvf release-file -C path creates' }

    it 'generates the expected command' do
      expect(subject.cherry_pick_tar_command(tar_args)).to eq(expected_result)
    end
  end

  describe '#tar_strip_args' do
    context 'when strip components is zero' do
      it 'generates no additional arguments'
    end

    context 'when strip components is greater than zero' do
      it 'generates an argument that displays the number of components to strip'
    end
  end
end
