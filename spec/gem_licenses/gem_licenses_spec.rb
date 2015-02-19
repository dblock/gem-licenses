require 'spec_helper'

describe Gem do
  it 'collects 3rd party licenses' do
    licenses = Gem.licenses
    expect(licenses.size).to eq(3)
    expect(licenses[:mit].size).to be >= 15
  end
end
