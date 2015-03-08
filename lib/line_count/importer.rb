require_relative '../line_count'

#
# Knows how to import PackManager line count information.
#

module LineCount
  class Importer

    def self.import
      new.import(filtered_csv_source)
    end

    def import(csv_source)
      puts csv_source
    end

    private

    def self.filtered_csv_source
      File.open(LineCount::FILTERED_FILENAME, 'r') { |f| f.read }
    end

  end
end
