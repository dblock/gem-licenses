require 'spec_helper'

describe Gem do
  subject do
    Gem.licenses
  end
  it 'collects 3rd party licenses' do
    expect(subject.size).to be > 0
  end
  it 'finds an MIT license for itself' do
    expect(subject['MIT'].size).to be > 0
    gem_licenses_spec = Gem::Specification.find_by_name('gem-licenses')
    gem_licenses_mit_spec = subject['MIT'].detect { |spec| spec == gem_licenses_spec }
    expect(gem_licenses_spec).to eq gem_licenses_mit_spec
  end

  it 'normalizes known license names' do
    expect(subject['GPLv2'].size).to be > 0
  end
end
