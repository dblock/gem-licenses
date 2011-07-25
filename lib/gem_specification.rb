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
          licenses = guess_licenses_from_file_contents File.join(full_gem_path, filename)
        end
      elsif filename_without_extension.include?("readme")
        licenses = guess_licenses_from_file_contents File.join(full_gem_path, filename)
      end
      break if licenses.length > 0
    end
    licenses << :unknown if licenses.length == 0
    licenses
  end

  private
  
  def guess_licenses_from_file_contents(path)
    licenses = []
    file_handle = File.new(path, "r")
    begin
      while (line = file_handle.gets)
        line = line.strip
        [ 
          /released under the (?<l>\w*) license/i,
          /^(?<l>\w*) license/i,
          /(the (?<l>\w*) license)/i,
          /license: ^(?<l>\w*)/i
        ].each do |r|
          res = Regexp.new(r).match(line)
          next unless res
          licenses << res['l']
          break
        end
      end
    rescue
      # TODO: warning
    end
    file_handle.close
    licenses
  end
  
end

