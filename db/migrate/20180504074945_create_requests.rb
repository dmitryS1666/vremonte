class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :body
      t.integer :owner_id
      t.integer :executor_id

      t.timestamps
    end
  end
end
