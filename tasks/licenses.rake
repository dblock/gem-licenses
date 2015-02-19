desc 'Gather open-source licenses.'
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
