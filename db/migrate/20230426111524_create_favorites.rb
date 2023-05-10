class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :user_id
      t.integer :book_id
      t.datetime :datetime #いらない
      
      t.timestamps null: false
    end
  end
end
