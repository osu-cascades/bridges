class RemoveOngoingFromActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :ongoing
  end
end
