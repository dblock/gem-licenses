module Gem
  def self.licenses
    licenses = {}
    config_path = File.expand_path('../../licenses/config.yml', __FILE__)
    config = YAML.safe_load(File.read(config_path))
    Gem.loaded_specs.each_value do |spec|
      spec.licenses.map(&:downcase).each do |license|
        license_name = config[license] || license
        licenses[license_name] ||= []
        licenses[license_name] << spec
      end
    end
    licenses
  end
end
