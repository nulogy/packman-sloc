class CodeCountForeignKey < ActiveRecord::Migration

  def change
    add_foreign_key :code_counts, :runs, on_delete: :cascade
  end

end
