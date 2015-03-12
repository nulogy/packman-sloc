require_relative '../line_count'
require_relative '../../lib/line_count/configuration'

#
# Knows how to generate line count information for PackManager.
#

module LineCount
  class Generator
    include Configuration

    def self.generate
      new.generate
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
        '--quiet',
        '--skip-uniqueness',
        '--unix',
        '--csv',
        '--3',
        '--by-file',
        '--force-lang=html,erb',
        "--report-file=#{LineCount::SLOC_RAW_FILENAME}",
      ]

      system("cloc #{options.join(' ')} #{fully_qualified_directories.join(' ')}")
    end

    def fully_qualified_directories
      directories.map { |directory| "#{root}#{directory}" }
    end

    def directories
      @directories ||= YAML.load_file(LineCount::PACKMAN_DIRECTORIES)
    end

    def filter_sloc
      File.open(SLOC_NORMALIZED_FILENAME, 'w') do |filtered|
        File.open(SLOC_RAW_FILENAME).each_with_index do |line, i|
          filtered << line.gsub(root, '') unless i.zero?
        end
      end
    end

  end
end
