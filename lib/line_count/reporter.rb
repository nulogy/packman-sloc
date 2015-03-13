module LineCount
  class Reporter

    def self.report(snapshot_id, language_filter)
      new(snapshot_id, language_filter).report
    end

    def self.languages
      puts CodeCount.pluck(:language).uniq().sort
    end

    def initialize(snapshot_id, language_filter)
      @snapshot_id = snapshot_id
      @language_filter = language_filter
    end

    def report
      puts format(results)
    end

    private

    def format(results)
      CSV.generate do |csv|
        csv << headers

        results.each do |result|
          csv << result
        end
      end
    end

    def headers
      ['Directory', 'Files', 'Lines']
    end

    def results
      ActiveRecord::Base.connection.execute(sql).map { |row| row.values }
    end

    def sql
      <<-SQL.strip_heredoc
        SELECT
          directory,
          count(lines) as files,
          sum(lines) as lines
        FROM
          code_counts
        WHERE
          snapshot_id = #{@snapshot_id}
          #{apply_language_filter}
        GROUP BY
          directory
        ORDER BY
          directory
      SQL
    end

    def apply_language_filter
      languages = @language_filter.split('|').map { |l| "'#{l}'" }

      languages.length.zero? ? "" : "AND language in (#{languages.join(', ')})"
    end

  end
end
