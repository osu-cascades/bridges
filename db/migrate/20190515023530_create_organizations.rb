class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :location
      t.string :ages_served
      t.string :programs
      t.string :contact_number
      t.string :contact_email
      t.string :website
      t.string :logo_url

      t.timestamps
    end
  end
end
