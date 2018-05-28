class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.belongs_to :request, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
