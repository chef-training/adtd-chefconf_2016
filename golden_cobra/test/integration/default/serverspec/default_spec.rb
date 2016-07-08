require 'spec_helper'

describe 'golden_cobra::default' do
  describe command('curl localhost:8000') do
    its(:stdout) { should match(/Congratulations on your first Django-powered page./) }
  end
end
