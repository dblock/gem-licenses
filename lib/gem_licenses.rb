module Gem

  require 'gem_specification'
  
  class << self
  
    def licenses
      licenses = {}
      Gem.loaded_specs.each do |key, spec|
        spec.licenses.each do |license|
          licenses[license.capitalize.to_sym] ||= []
          licenses[license.capitalize.to_sym] << spec
        end
      end
      licenses
    end
  
  end
end
