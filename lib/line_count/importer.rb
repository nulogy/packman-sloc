require 'csv'

require_relative '../line_count'
require_relative 'configuration'

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

    attr_reader :configuration

    def initialize
      @configuration = Configuration.new
    end

    def import(csv_source)
      ActiveRecord::Base.transaction do
        snapshot = Snapshot.create! snapshot_attrs

        CSV.parse(csv_source) do |row|
          next if filter_out(row)

          CodeCount.create! code_count_attrs(snapshot, row)
        end
      end
    end

    private

    def self.normalized_csv_source
      File.open(LineCount::SLOC_NORMALIZED_FILENAME, 'r') { |f| f.read }
    end

    def snapshot_attrs
      attrs = {}

      Dir.chdir(configuration.root) do
        from = `git show --format=%ci HEAD`
        sha = `git rev-parse HEAD`

        attrs = { from: from, sha: sha }
      end

      attrs
    end

    def filter_out(row)
       configuration.filters_matcher.match(row[filename_index])
    end

    def filename_index
      CODE_COUNT_ATTRIBUTES.index('filename')
    end

    def code_count_attrs(snapshot, row)
      { snapshot: snapshot, directory: directory(row) }.merge(Hash[CODE_COUNT_ATTRIBUTES.zip(row)])
    end

    def directory(row)
      configuration.directories_matcher.match(row[filename_index])[1]
    end

  end
end
