require_relative '../line_count/utils'

namespace :utils do

  desc 'List all file extensions'
  task :file_extensions do
    LineCount::Utils.file_extensions
  end

end
