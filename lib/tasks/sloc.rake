require_relative '../line_count/generator'
require_relative '../line_count/importer'
require_relative '../line_count/run_report'

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
    Run.all.each { |run| puts run.to_s }
  end

  desc 'Generate a report of PackManager source code metrics for the specified run'
  task :report, [:run_id] => :environment do |_, args|
    LineCount::RunReport.generate(args.run_id)
  end

end
