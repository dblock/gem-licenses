module Gem
  class Specification
    alias_method :__licenses, :licenses

    LICENSE_REFERENCES = [
      /released under the (?<l>[\s\w]*) license/i,
      /same license as (?<l>[\s\w]*)/i,
      /^(?<l>[\s\w]*) License, see/i,
      /^(?<l>[\w]*) license$/i,
      /\(the (?<l>[\s\w]*) license\)/i,
      /^license: (?<l>[\s\w]*)/i,
      /^released under the (?<l>[\s\w]*) license/i,
      /license: (?<l>[\s\w]*)$/i,
      /^same as (?<l>[\s\w]*)/i,
      /license of (?<l>[\s\w]*)/i
    ]

    def licenses
      ary = (__licenses || []).keep_if { |l| l.length > 0 }
      ary.length == 0 ? guess_licenses : ary
    end

    def guess_licenses
      licenses = []
      Dir.foreach(full_gem_path) do |filename|
        filename_without_extension = File.basename(filename, File.extname(filename)).downcase
        if filename_without_extension.include?('license')
          parts = filename.split('-')
          if (parts.length >= 2)
            licenses << parts[0].upcase
          else
            licenses = guess_licenses_from_file File.join(full_gem_path, filename)
          end
        elsif filename_without_extension.include?('readme')
          licenses = guess_licenses_from_file File.join(full_gem_path, filename)
        end
        break if licenses.length > 0
      end
      licenses << :unknown if licenses.length == 0
      licenses
    rescue Errno::ENOENT
      # TODO: warning
      []
    end

    def self.common_licenses
      @common_licenses ||= Hash[
        Dir.glob(File.expand_path('../../../common_licenses/*', __FILE__)).map do |f|
          [File.basename(f), normalize_text(File.read(f))]
        end
      ]
    end

    def self.normalize_text(text)
      text.downcase.to_s.gsub(/[[:space:]]+/, ' ').gsub(/[[:punct:]]/, '').strip
    end

    private

    def guess_licenses_from_file(path)
      licenses = guess_licenses_from_reference(path)
      return licenses if licenses.any?
      guess_licenses_from_contents(path)
    end

    def guess_licenses_from_reference(path)
      file_handle = File.new(path, 'r')
      begin
        while (line = file_handle.gets)
          line = line.strip
          # positive matches
          LICENSE_REFERENCES.each do |r|
            res = r.match(line)
            return [res['l']] if res
          end
        end
      rescue
        # TODO: warning
      ensure
        file_handle.close
      end
      []
    end

    def guess_licenses_from_contents(path)
      File.open(path, 'r') do |file|
        contents = file.read
        match, _ = self.class.common_licenses.detect do |_key, lic|
          self.class.normalize_text(contents).include?(lic)
        end
        return [match].compact
      end
    end
  end
end
