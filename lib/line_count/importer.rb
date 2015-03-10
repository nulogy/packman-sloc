require 'csv'

require_relative '../line_count'
require_relative '../../lib/line_count/directory_helper'

#
# Knows how to import PackManager line count information.
#

module LineCount
  class Importer
    include DirectoryHelper

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
        run = Run.create! run_attrs

        CSV.parse(csv_source) do |row|
          next if filter_out(row)

          CodeCount.create! code_count_attrs(run, row)
        end
      end
    end

    private

    def self.normalized_csv_source
      File.open(LineCount::SLOC_NORMALIZED_FILENAME, 'r') { |f| f.read }
    end

    def run_attrs
      branch = ''
      sha = ''

      Dir.chdir(root) do
        branch = `git symbolic-ref --short HEAD`
        sha = `git rev-parse HEAD`
      end

      { branch: branch, sha: sha }
    end

    def filter_out(row)
       filters_matcher.match(row[filename_index])
    end

    def filename_index
      CODE_COUNT_ATTRIBUTES.index('filename')
    end

    def filters_matcher
      @filters_matcher ||= Regexp.new(YAML.load_file(LineCount::PACKMAN_FILTERS).join('|'))
    end

    def code_count_attrs(run, row)
      { run: run, directory: directory(row) }.merge(Hash[CODE_COUNT_ATTRIBUTES.zip(row)])
    end

    def directory(row)
      directories_matcher.match(row[filename_index])[1]
    end

    def directories_matcher
      @directories_matcher ||= Regexp.new("^(#{YAML.load_file(LineCount::PACKMAN_DIRECTORIES).join('|')})/.*")
    end

  end
end
