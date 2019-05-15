class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :who
      t.string :what
      t.string :where
      t.string :when
      t.string :how
      t.string :details
      t.string :title

      t.timestamps
    end
  end
end
