desc 'Gather open-source licenses.'
namespace :gem do
  task :licenses do
    Gem::GemLicenses::Report.text(Gem.licenses)
  end

  namespace :licenses do
    task :csv, [:filename] do |_t, args|
      abort 'Missing CSV filename, run rake gem:licenses:csv[licenses.csv].' if args[:filename].to_s.strip.empty?

      Gem::GemLicenses::Report.csv(Gem.licenses, File.expand_path(args[:filename], Dir.pwd))
    end

    namespace :copyrights do
      task :csv, [:filename] do |_t, args|
        if args[:filename].to_s.strip.empty?
          abort 'Missing CSV filename, run rake gem:licenses:copyrights:csv[copyrights.csv].'
        end

        require 'csv'
        filename = File.expand_path(args[:filename], Dir.pwd)
        puts "Writing #{filename} ..."
        total = 0
        CSV.open(filename, 'w') do |csv|
          csv << %w[name version homepage summary license copyright]
          Gem.licenses.each do |license, gems|
            total += gems.count
            gems.sort_by(&:name).each do |gem|
              csv << [gem.name, gem.version, gem.homepage, gem.summary.strip, license, gem.copyrights.join('; ')]
            end
          end
        end
        puts "Written licenses and copyrights for #{total} project(s)."
      end
    end
  end
end
