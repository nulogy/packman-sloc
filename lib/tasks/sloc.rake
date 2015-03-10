require_relative '../line_count/generator'
require_relative '../line_count/importer'

namespace :sloc do

  desc 'Capture a run of PackManager source code metrics'
  task :capture => [:generate, :import] do
  end

  desc 'Clear PackManager source code metrics for the specified run'
  task :clear, [:run_id] => :environment do |_, args|
    Run.delete(args.run_id)
  end

  desc 'Generate PackManager source code metrics'
  task :generate do
    LineCount::Generator.generate
  end

  desc 'Import generated PackManager source code metrics'
  task :import => :environment do
    LineCount::Importer.import
  end

  desc 'List all runs of PackManager source code metrics'
  task :list => :environment do
    Run.all.each { |run| puts "Run #{run.id} at #{run.created_at}" }
  end

end
