require 'csv'

require_relative '../line_count'

#
# Knows how to import PackManager line count information.
#

module LineCount
  class Importer

    # Specifies the position of CodeCount attributes in the generated CSV.
    # See http://cloc.sourceforge.net/ for the CSV format.
    CODE_COUNT_ATTRIBUTES = [
      'language',
      'filename',
      'blanks',
      'comments',
      'lines',
      'scale',
      'scaled_lines'
    ]

    def self.import
      new.import(normalized_csv_source)
    end

    def import(csv_source)
      ActiveRecord::Base.transaction do
        run = Run.create!

        CSV.parse(csv_source) do |row|
          next if filter_out(row)

          CodeCount.create! attrs(run, row)
        end
      end
    end

    private

    def self.normalized_csv_source
      File.open(LineCount::SLOC_NORMALIZED_FILENAME, 'r') { |f| f.read }
    end

    def filter_out(row)
       filters.match(row[filename_index])
    end

    def filename_index
      CODE_COUNT_ATTRIBUTES.index('filename')
    end

    def filters
      @filters ||= Regexp.new(YAML.load_file(LineCount::PACKMAN_FILTERS).join('|'))
    end

    def attrs(run, row)
      { run: run, directory: directory(row) }.merge(Hash[CODE_COUNT_ATTRIBUTES.zip(row)])
    end

    def directory(row)
      directories.match(row[filename_index])[1]
    end

    def directories
      @directories ||= Regexp.new("^(#{YAML.load_file(LineCount::PACKMAN_DIRECTORIES).join('|')})/.*")
    end

  end
end
