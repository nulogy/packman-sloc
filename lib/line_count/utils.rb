require 'find'

require_relative '../line_count'
require_relative 'configuration'

#
# Backs the util rake tasks.
#

module LineCount
  class Utils

    def self.file_extensions
      new.file_extensions
    end

    attr_reader :configuration

    def initialize
      @configuration = Configuration.new
    end

    def file_extensions
      result = []

      Find.find(root) do |path|
        path = path.gsub(root, '')

        next unless (path =~ configuration.directories_matcher && path !~ configuration.filters_matcher)

        if File.basename(path).match('^.*\.(\w*)')
          result << $1
        end
      end

      result.inject(Hash.new(0)) { |h, x| h[x] += 1; h }.to_a.sort { |a, b| b[1] <=> a[1] }.each do |lanugauge, count|
        puts "#{lanugauge} #{count}"
      end
    end

  end
end
