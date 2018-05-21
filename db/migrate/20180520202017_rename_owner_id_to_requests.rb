class RenameOwnerIdToRequests < ActiveRecord::Migration[5.2]
  def change
    rename_column :requests, :owner_id, :user_id
  end
end
