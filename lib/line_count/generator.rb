#
# Knows how to generate line count information for PackManager.
#

module LineCount
  class Generator

    OUTPUT_FILENAME = 'tmp/sloc/packman_sloc.csv'
    FILTERED_FILENAME = 'tmp/sloc/packman_sloc_filtered.csv'

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

      [OUTPUT_FILENAME, FILTERED_FILENAME].each do |filename|
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
        "--report-file=#{OUTPUT_FILENAME}",
      ]

      # ARM (15-03-08): Check error conditions?
      system("cloc #{options.join(' ')} #{fully_qualified(directories).join(' ')}")
    end

    # PackManager directories containing the source code that we want to count.
    def directories
      [
        'app',
        'test',
        'spec',
      ]
    end

    def fully_qualified(directories)
      directories.map { |directory| "#{root}#{directory}" }
    end

    def root
      "#{ENV['PACKMANAGER_DIR']}/dev/"
    end

    def filter_sloc
      File.open(FILTERED_FILENAME, 'w') do |filtered|
        File.open(OUTPUT_FILENAME).each do |line|
          filtered << line.gsub(root, '')
        end
      end
    end

  end
end
