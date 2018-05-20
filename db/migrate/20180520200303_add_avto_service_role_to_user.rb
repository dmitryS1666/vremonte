class AddAvtoServiceRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avservice, :boolean, default: false
  end
end
