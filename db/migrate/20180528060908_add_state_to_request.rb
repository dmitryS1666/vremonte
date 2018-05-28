class AddStateToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :state, :string
  end
end
