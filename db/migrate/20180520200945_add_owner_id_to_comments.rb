class AddOwnerIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :owner_id, :integer
  end
end
