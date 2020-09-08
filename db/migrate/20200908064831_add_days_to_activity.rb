class AddDaysToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :days, :string
  end
end
