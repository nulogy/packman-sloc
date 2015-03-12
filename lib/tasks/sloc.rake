require_relative '../line_count/generator'
require_relative '../line_count/importer'
require_relative '../line_count/reporter'

namespace :sloc do

  desc 'Capture a snapshot of PackManager source code metrics'
  task :capture => [:generate, :import] do
  end

  desc 'Clear PackManager source code metrics for the specified snapshot'
  task :clear, [:snapshot_id] => :environment do |_, args|
    Snapshot.delete(args.snapshot_id)
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
    Snapshot.all.each { |snapshot| puts snapshot.to_s }
  end

  desc 'Generate a report of PackManager source code metrics for the specified snapshot'
  task :report, [:snapshot_id] => :environment do |_, args|
    LineCount::Reporter.report(args.snapshot_id)
  end

end
