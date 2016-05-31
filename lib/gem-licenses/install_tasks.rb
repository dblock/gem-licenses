module Gem
  module GemLicenses
    def self.install_tasks
      spec = Gem::Specification.find_by_name('gem-licenses')
      Dir[File.join(spec.gem_dir, 'tasks/*.rake')].each do |file|
        load file
      end
    end
  end
end
