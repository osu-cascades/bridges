class RemoveWhenStartAndWhenEndFromActivities < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :when_start
    remove_column :activities, :when_end
  end
end
