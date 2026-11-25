# frozen_string_literal: true

module Gem
  module GemLicenses
    # Loads the gem-licenses Rake tasks into Rails applications.
    class Railtie < ::Rails::Railtie
      rake_tasks do
        Gem::GemLicenses.install_tasks
      end
    end
  end
end
