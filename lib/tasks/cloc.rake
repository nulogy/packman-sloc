require_relative '../line_count'

namespace :sloc do

  desc 'Generate PackManager source code metrics'
  task :generate do
    LineCount.generate
  end

end
