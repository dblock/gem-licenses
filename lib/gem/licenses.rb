module Gem
  def self.licenses
    licenses = {}
    Gem.loaded_specs.each do |_key, spec|
      spec.licenses.map(&:downcase).map(&:to_sym).each do |license|
        licenses[license] ||= []
        licenses[license] << spec
      end
    end
    licenses
  end
end
