class CodeCountForeignKey < ActiveRecord::Migration

  def change
    add_foreign_key :code_counts, :snapshots, on_delete: :cascade
  end

end
