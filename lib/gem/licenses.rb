module Gem
  def self.licenses(specs = Gem.loaded_specs.values)
    licenses = {}
    config_path = File.expand_path('../../licenses/config.yml', __FILE__)
    config = YAML.safe_load(File.read(config_path))
    specs.each do |spec|
      spec.licenses.map(&:downcase).each do |license|
        license_name = config[license] || license
        licenses[license_name] ||= []
        licenses[license_name] << spec
      end
    end
    licenses
  end
end
