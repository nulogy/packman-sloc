class CodeCountForeignKey < ActiveRecord::Migration

  def change
    add_foreign_key :code_counts, :runs
  end

end
