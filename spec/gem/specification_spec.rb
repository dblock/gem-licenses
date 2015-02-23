require 'spec_helper'

describe Gem::Specification do
  def gem_dir(label)
    File.expand_path("../../fixtures/gems/#{label}", __FILE__)
  end

  let(:spec) { Gem::Specification.new }

  it 'finds text matching the MIT license in README' do
    allow(spec).to receive(:full_gem_path).and_return(gem_dir('mit_license_in_readme'))
    expect(spec.guess_licenses).to eq(['mit-v2'])
  end

  it 'tolerates whitespace, capitalization, and punctuation discrepancies' do
    allow(spec).to receive(:full_gem_path).and_return(gem_dir('mit_license_in_readme_with_discrepancies'))
    expect(spec.guess_licenses).to eq(['mit-v2'])
  end

  it 'matches "released under the ___ license"' do
    allow(spec).to receive(:full_gem_path).and_return(gem_dir('released_under_the_bsd_license'))
    expect(spec.guess_licenses).to eq(['BSD'])
  end

  it 'matches "same license as ___"' do
    allow(spec).to receive(:full_gem_path).and_return(gem_dir('same_license_as_ruby'))
    expect(spec.guess_licenses).to eq(['Ruby'])
  end

  it 'gracefully recovers from unparseable files' do
    allow(spec).to receive(:full_gem_path).and_return(gem_dir('nonstandard_characters'))
    expect(spec.guess_licenses).to eq(['unknown'])
  end
end
