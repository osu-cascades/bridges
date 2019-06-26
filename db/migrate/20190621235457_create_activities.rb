class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :who
      t.string :what
      t.string :where
      t.datetime :when_start
      t.datetime :when_end
      t.string :how
      t.string :details
      t.string :title
      t.integer :state

      t.timestamps
    end
  end
end