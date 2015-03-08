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
    File.delete(OUTPUT_FILENAME) if File.exist?(OUTPUT_FILENAME)
  end

  def generate_sloc_sql
    options = [
      '--quiet',
      '--force-lang=html,erb',
      "--sql=#{OUTPUT_FILENAME}",
      '--sql-append',
      '--sql-project=packman-sloc',
      '--list-file=lib/tasks/packman_files.txt'
    ]

    # ARM (15-03-08): Check error conditions?
    system("cloc #{options.join(' ')}")
  end

end
