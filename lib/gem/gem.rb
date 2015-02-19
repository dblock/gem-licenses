module Gem

  require 'gem/specification'

  class << self

    def licenses
      licenses = {}
      Gem.loaded_specs.each do |key, spec|
        spec.licenses.map(&:downcase).map(&:to_sym).each do |license|
          licenses[license] ||= []
          licenses[license] << spec
        end
      end
      licenses
    end

  end
end
