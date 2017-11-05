require 'gem_licenses'

if defined?(Rails)
  # Railtie for gem-licenses
  class GemLicensesRakeTask < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
    end
  end
end
