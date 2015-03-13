module LineCount
  module Configuration

    PACKMAN_DIRECTORIES = 'lib/line_count/packman_directories.yml'
    PACKMAN_FILTERS = 'lib/line_count/packman_filters.yml'

    def root
      "#{ENV['PACKMANAGER_DIR']}/sloc/"
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
