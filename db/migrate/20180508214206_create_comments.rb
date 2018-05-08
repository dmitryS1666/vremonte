class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps
      # t.belongs_to :user, index: true, foreign_key: true
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
