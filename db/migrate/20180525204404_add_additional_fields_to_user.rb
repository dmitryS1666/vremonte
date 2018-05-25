class AddAdditionalFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :additional_fields, :string
  end
end
