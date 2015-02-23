require 'spec_helper'

describe Gem::Specification do
  let(:spec) { Gem::Specification.new }

  it 'finds text matching the MIT license in README' do
    allow(spec).to receive(:full_gem_path).and_return(File.expand_path('../../fixtures/gems/mit_license_in_readme', __FILE__))
    expect(spec.guess_licenses).to eq(['mit-v2'])
  end

  it 'tolerates whitespace, capitalization, and punctuation discrepancies' do
    allow(spec).to receive(:full_gem_path).and_return(File.expand_path('../../fixtures/gems/mit_license_in_readme_with_minor_discrepancies', __FILE__))
    expect(spec.guess_licenses).to eq(['mit-v2'])
  end

  it 'matches "released under the ___ license"' do
    allow(spec).to receive(:full_gem_path).and_return(File.expand_path('../../fixtures/gems/released_under_the_bsd_license', __FILE__))
    expect(spec.guess_licenses).to eq(['BSD'])
  end

  it 'matches "same license as ___"' do
    allow(spec).to receive(:full_gem_path).and_return(File.expand_path('../../fixtures/gems/same_license_as_ruby', __FILE__))
    expect(spec.guess_licenses).to eq(['Ruby'])
  end

  it 'gracefully recovers from unparseable files' do
    allow(spec).to receive(:full_gem_path).and_return(File.expand_path('../../fixtures/gems/nonstandard_characters', __FILE__))
    expect(spec.guess_licenses).to eq(['unknown'])
  end
end
