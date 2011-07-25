module Gem

  require 'gem_specification'
  
  class << self
  
    def licenses
      licenses = {}
      Gem.loaded_specs.each do |key, spec|
        # gemspec defines licenses
        spec.licenses.each do |license|
          licenses[license.to_sym] ||= []
          licenses[license.to_sym] << spec
        end
      end
      licenses
    end
  
  end
end
