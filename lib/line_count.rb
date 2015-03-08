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
      '--sql-project=packman-sloc'
    ]

    directories = [
      '/Users/alistair/src/packmanager/dev/app',
      '/Users/alistair/src/packmanager/dev/test',
      '/Users/alistair/src/packmanager/dev/spec',
    ]

    # ARM (15-03-08): Check error conditions?
    system("cloc #{options.join(' ')} #{directories.join(' ')}")
  end

end
