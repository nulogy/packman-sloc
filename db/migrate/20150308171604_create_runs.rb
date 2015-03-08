class CreateRuns < ActiveRecord::Migration

  def change
    create_table :runs do |t|
      t.string :tag, null: false

      t.timestamps null: false
    end
  end

end
