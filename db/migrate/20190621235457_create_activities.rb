class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.datetime :when_start
      t.datetime :when_end
      t.text :description
      t.string :location
      t.string :contact_name
      t.string :contact_number
      t.string :contact_email
      t.integer :state
      t.boolean :recurring

      t.timestamps
    end
  end
end
