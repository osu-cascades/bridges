class AddUrlToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :url, :string, null: true
  end
end
