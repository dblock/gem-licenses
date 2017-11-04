module Gem
  class Specification
    alias __licenses licenses

    LICENSE_REFERENCES = [
      /released under the (?<l>[\s\w]+) license/i,
      /same license as (?<l>[\s\w]+)/i,
      /same terms of (.+)/i,
      /^(?<l>[\s\w]+) License, see/i,
      /^(?<l>[\w]+) license$/i,
      /\(the (?<l>[\s\w]+) license\)/i,
      /^license: (?<l>[\s\w]+)/i,
      /^released under the (?<l>[\s\w]+) license/i,
      /license: (?<l>[\s\w]+)$/i,
      /^same as (?<l>[\s\w]+)/i,
      /license of (?<l>[\s\w]+)/i
    ].freeze

    def licenses
      cleaned_up_licenses
    end

    def cleaned_up_licenses
      before = gem_or_file_license

      log_warning "License #{before.inspect}"

      # manually clean up some cruft
      after = before.collect do |license|
        stringified = license.to_s
        if stringified == 'mit'
          'MIT'
        elsif stringified == 'lgpl'
          'LGPL'
        elsif stringified == 'gpl'
          'GPL'
        else
          stringified
        end
      end

      log_warning "  Cleaned #{after.inspect}" if before != after

      after
    end

    def gem_or_file_license
      from_gem || guess_licenses
    end

    def from_gem
      result = (__licenses || []).reject(&:empty?)
      if !result.empty?
        log_warning 'Retrieved from Gem license' if debugging?
        result
      else
        log_warning 'Guessing from file'
        nil
      end
    end

    def guess_licenses
      licenses = []
      Dir.foreach(full_gem_path) do |filename|
        case File.basename(filename, File.extname(filename)).downcase
        when /license/
          parts = filename.split('-')
          return [parts[0].upcase] if parts.length >= 2
          licenses = guess_licenses_from_file File.join(full_gem_path, filename)
        when /copying|readme/
          licenses = guess_licenses_from_file File.join(full_gem_path, filename)
        end
        break unless licenses.empty?
      end
      licenses << 'unknown' if licenses.empty?
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
    rescue ArgumentError
      nil
    end

    private

    def debugging?
      ENV['DEBUG']
    end

    def log_warning(message)
      warn message if debugging?
    end

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
      rescue StandardError => e
        # TODO: Print a useful warning
        log_warning e.message
      ensure
        file_handle.close
      end
      []
    end

    def guess_licenses_from_contents(path)
      File.open(path, 'r') do |file|
        contents = file.read
        match, = self.class.common_licenses.detect do |_key, lic|
          normalized = self.class.normalize_text(contents)
          normalized.include?(lic) if normalized
        end
        return [match].compact
      end
    end
  end
end
