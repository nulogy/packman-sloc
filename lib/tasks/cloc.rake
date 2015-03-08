namespace :sloc do

  task :default => :generate

  desc 'Generate Pack Manager source code metrics'
  task generate: :environment do
    cmd = 'cloc --quiet  --force-lang=html,erb --sql=tmp/packman_sloc.sql --sql-append --list-file=lib/tasks/packman_files.txt'
    system(cmd)
  end

end
