module LineCount
  class Reporter

    def self.report(snapshot_id)
      new(snapshot_id).report
    end

    def initialize(snapshot_id)
      @snapshot_id = snapshot_id
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
        GROUP BY
          directory
        ORDER BY
          directory
      SQL
    end

  end
end
