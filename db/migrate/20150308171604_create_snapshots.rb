class CreateSnapshots < ActiveRecord::Migration

  def change
    create_table :snapshots do |t|
      t.string :branch, null: false
      t.datetime :from, null: false
      t.string :sha, null: false

      t.timestamps null: false
    end
  end

end
