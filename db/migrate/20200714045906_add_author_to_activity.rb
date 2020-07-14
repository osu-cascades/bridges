class AddAuthorToActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :author, index: true, null: true
    add_foreign_key :activities, :users, column: :author_id
  end
end
