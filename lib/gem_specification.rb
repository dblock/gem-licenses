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
      next unless filename_without_extension.include?("license")
      parts = filename.split('-')
      if (parts.length >= 2)
        licenses << parts[0].upcase
      else
        license_file = File.join(full_gem_path, filename)
        license_file_handle = File.new(license_file, "r")
        while (line = license_file_handle.gets)
          line = line.strip
          licenses << "MIT" if line.include? "MIT License"
        end
      end
    end
    licenses << :unknown if licenses.length == 0
    licenses
  end

end

