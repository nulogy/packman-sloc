require 'csv'

require_relative '../line_count'

#
# Knows how to import PackManager line count information.
#

module LineCount
  class Importer

    # Maps to CodeCount attributes by position in the generated CSV.
    CODE_COUNT_FIELDS = [
      'language',
      'filename',
      'blanks',
      'comments',
      'lines',
      'scale',
      'scaled_lines',
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
      # ARM (15-03-10): TBD. Null filter for the moment.
      false
    end

    def filters
      @filters ||= YAML.load_file(LineCount::PACKMAN_FILTERS)
    end

    def attrs(run, row)
      { run: run }.merge(Hash[CODE_COUNT_FIELDS.zip(row)])
    end

  end
end
