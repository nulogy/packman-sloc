require_relative '../line_count'
require_relative '../../lib/line_count/configuration'

#
# Backs the util rake tasks.
#

module LineCount
  class Utils
    include Configuration

    def self.file_extensions
      new.file_extensions
    end

    def file_extensions
      Dir.chdir(root) do
        puts `find . -type f | xargs basename | awk -F. '/\\./ { print $NF }' | sort | uniq -c | sort -r`
      end
    end

  end
end
