desc 'Gather open-source licenses.'
namespace :gem do
  task :licenses do
    Gem.licenses.each do |license, gems|
      puts "#{license}"
      puts '=' * license.length
      gems.sort_by(&:name).each do |gem|
        puts "* #{gem.name} #{gem.version} (#{gem.homepage}) - #{gem.summary.strip}"
        puts gem.full_gem_path
      end
      puts ''
    end
  end

  namespace :licenses do
    task :csv do |_t, args|
      filename = ARGV[1] || 'licences.csv'
      require 'csv'
      filename = File.expand_path(filename, Dir.pwd)
      puts "Writing #{filename} ..."
      licenses = Gem.licenses
      total = 0
      CSV.open(filename, 'w') do |csv|
        csv << %w(name version homepage summary license)
        licenses.each do |license, gems|
          total += gems.count
          gems.sort_by(&:name).each do |gem|
            csv << [gem.name, gem.version, gem.homepage, gem.summary.strip, license]
          end
        end
      end
      puts "Written #{licenses.keys.count} license(s) for #{total} project(s): #{licenses.keys.join(', ')}"

      if licenses.key?('unknown')
        puts "IMPORTANT: You have #{licenses['unknown'].count} projects without a guessable license!"
        licenses['unknown'].each do |gem|
          puts "  #{gem.name}: #{gem.full_gem_path}"
        end
      end
    end
  end
end
