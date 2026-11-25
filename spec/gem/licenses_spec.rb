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
    gpl_spec = Gem::Specification.new do |spec|
      spec.name = 'gpl-gem'
      spec.version = '1.0.0'
      spec.licenses = ['GPL-2']
    end
    allow(Gem).to receive(:loaded_specs).and_return('gpl-gem' => gpl_spec)
    expect(subject['GPLv2']).to eq [gpl_spec]
  end
end
