#
# Knows how to generate line count information for PackManager.
#

class LineCount

  OUTPUT_FILENAME = 'tmp/packman_sloc.sql'

  def self.generate
    new.generate
  end

  def generate
    clean
    generate_sloc_sql
  end

  private

  def clean
    # ARM (15-03-08): Create the tmp/ directory or assume that it exists?
    File.delete(OUTPUT_FILENAME) if File.exist?(OUTPUT_FILENAME)
  end

  def generate_sloc_sql
    options = [
      '--quiet',
      '--force-lang=html,erb',
      "--sql=#{OUTPUT_FILENAME}",
      '--sql-append',
      '--sql-project=packman-sloc'
    ]

    # ARM (15-03-08): Check error conditions?
    system("cloc #{options.join(' ')} #{fully_qualified(directories).join(' ')}")
  end

  # PackManager directories containing the source code that we want to count.
  def directories
    [
      'app',
      'test',
      'spec',
    ]
  end

  def fully_qualified(directories)
    root = "#{ENV['PACKMANAGER_DIR']}/dev"
    directories.map { |directory| "#{root}/#{directory}" }
  end

end
