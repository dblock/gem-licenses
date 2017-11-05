module Gem
  module GemLicenses
    # Railtie for gem-licenses gem
    #
    # Exposes this gem's Rake tasks to the Rails app.
    class GemLicensesRailtie < Rails::Railtie
      rake_tasks do
        install_tasks
      end
    end
  end
end
