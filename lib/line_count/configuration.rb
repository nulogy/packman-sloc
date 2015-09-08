module LineCount
  class Configuration

    PACKMAN_DIRECTORIES = './packman_directories.yml'
    PACKMAN_FILTERS = './packman_filters.yml'

    def root
      "#{ENV['SLOC_DIR']}/"
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
