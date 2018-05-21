class RenameOwnerIdToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :owner_id, :user_id
  end
end
