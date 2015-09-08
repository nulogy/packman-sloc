module LineCount
  class Configuration

    PACKMAN_DIRECTORIES = './packman_directories.yml'
    PACKMAN_FILTERS = './packman_filters.yml'

    def root
      sloc_dir = ENV['SLOC_DIR']

      raise('Undefined environment variable: SLOC_DIR') if sloc_dir.nil?

      "#{sloc_dir}/"
    end

    def directories
      @directories ||= YAML.load_file(PACKMAN_DIRECTORIES)
    end

    def directories_matcher
      @directories_matcher ||= Regexp.new("^(#{directories.join('|')})/.*")
    end

    def filters
      @filters ||= YAML.load_file(PACKMAN_FILTERS)
    end

    def filters_matcher
      @filters_matcher ||= Regexp.new(filters.join('|'))
    end

  end
end
