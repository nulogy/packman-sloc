require_relative '../line_count'
require_relative 'configuration'

#
# Knows how to generate line count information for PackManager.
#

module LineCount
  class Generator

    def self.generate
      new.generate
    end

    attr_reader :configuration

    def initialize
      @configuration = Configuration.new
    end

    def generate
      clean
      generate_sloc
      filter_sloc
    end

    private

    def clean
      FileUtils::mkdir_p 'tmp/sloc'

      [LineCount::SLOC_RAW_FILENAME, LineCount::SLOC_NORMALIZED_FILENAME].each do |filename|
        File.delete(filename) if File.exist?(filename)
      end
    end

    def generate_sloc
      options = [
        '--by-file',
        '--csv',
        '--force-lang=html,erb',
        '--quiet',
        '--skip-uniqueness',
        '--unix',
        '--3',
        "--report-file=#{LineCount::SLOC_RAW_FILENAME}",
      ]

      system("cloc #{options.join(' ')} #{fully_qualified_directories.join(' ')}")
    end

    def fully_qualified_directories
      configuration.directories
        .map { |directory| "#{configuration.root}#{directory}" }
        .select { |directory| File.exists?(directory) }
    end

    def filter_sloc
      File.open(SLOC_NORMALIZED_FILENAME, 'w') do |filtered|
        File.open(SLOC_RAW_FILENAME).each_with_index do |line, i|
          filtered << line.gsub(configuration.root, '') unless i.zero?
        end
      end
    end

  end
end
