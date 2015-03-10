class CreateCodeCounts < ActiveRecord::Migration

  def change
    create_table :code_counts do |t|
      t.integer :run_id, null: false

      t.string :directory, null: false
      t.string :language, null: false
      t.string :filename, null: false

      t.integer :blanks, null: false
      t.integer :comments, null: false
      t.integer :lines, null: false

      t.decimal :scale, null: false
      t.decimal :scaled_lines, null: false
    end
  end

end
