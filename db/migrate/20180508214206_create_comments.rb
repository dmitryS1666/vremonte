class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :request, index: true, foreign_key: true
      t.timestamps
      # t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
