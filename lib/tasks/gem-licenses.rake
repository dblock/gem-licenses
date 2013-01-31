include Rake::DSL

desc "Print list of gems grouped by the licenses they use"
task :licenses do
  Gem.licenses.each do |license, gems|
    puts "#{license}"
    puts "----------"
    gems.sort_by { |gem| gem.name }.each do |gem|
      puts "* #{gem.name} #{gem.version} (#{gem.homepage}) - #{gem.summary}"
    end
    puts
  end
end
