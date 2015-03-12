class CreateRuns < ActiveRecord::Migration

  def change
    create_table :runs do |t|
      t.string :branch, null: false
      t.datetime :from, null: false
      t.string :sha, null: false

      t.timestamps null: false
    end
  end

end
