class RemoveLogoUrlFromOrganizations < ActiveRecord::Migration[5.2]
  def change
    remove_column :organizations, :logo_url
  end
end
