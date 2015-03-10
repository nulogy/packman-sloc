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
      new.import(filtered_csv_source)
    end

    def import(csv_source)
      ActiveRecord::Base.transaction do
        run = Run.create!

        CSV.parse(csv_source) do |row|
          CodeCount.create! attrs(run, row)
        end
      end
    end

    private

    def self.filtered_csv_source
      File.open(LineCount::FILTERED_FILENAME, 'r') { |f| f.read }
    end

    def attrs(run, row)
      { run: run }.merge(Hash[CODE_COUNT_FIELDS.zip(row)])
    end

  end
end
