require_relative '../line_count/generator'
require_relative '../line_count/importer'

namespace :sloc do

  desc 'Generate PackManager source code metrics'
  task :generate do
    LineCount::Generator.generate
  end

  desc 'Import the generated PackManager source code metrics'
  task :import do
    LineCount::Importer.import
  end

end
