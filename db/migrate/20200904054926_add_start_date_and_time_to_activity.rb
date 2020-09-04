class AddStartDateAndTimeToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :start_date, :date
    add_column :activities, :start_time, :time
  end
end
