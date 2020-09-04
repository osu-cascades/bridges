class AddEndDateAndTimeToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :end_date, :date
    add_column :activities, :end_time, :time
  end
end
