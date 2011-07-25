class Gem::Specification
  alias_method :__licenses, :licenses

  def licenses
    ary = __licenses || []
    ary.length == 0 ? guess_licenses : ary
  end
  
  def guess_licenses
    licenses = []
    Dir.foreach(full_gem_path) do |filename|
      filename_without_extension = File.basename(filename, File.extname(filename)).downcase
      if filename_without_extension.include?("license")
        parts = filename.split('-')
        if (parts.length >= 2)
          licenses << parts[0].upcase
        else
          license_file = File.join(full_gem_path, filename)
          license_file_handle = File.new(license_file, "r")
          while (line = license_file_handle.gets)
            line = line.strip
            if line.include? "MIT License"
              licenses << "MIT" 
              break
            end
          end
          license_file_handle.close
        end
      elsif filename_without_extension.include?("readme")
        readme_file = File.join(full_gem_path, filename)
        readme_file_handle = File.new(readme_file, "r")
        while (line = readme_file_handle.gets)
          line = line.strip
          if line.include? "MIT License"
            licenses << "MIT"
            break
          elsif line.start_with? "license:"
            licenses << line.split(':')[1]
            break
          end
        end
      end
      break if licenses.length > 0
    end
    licenses << :unknown if licenses.length == 0
    licenses
  end

end

