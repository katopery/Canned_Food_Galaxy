class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :member, null: false, foreign_key: true
      t.references :canned_food, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :favorites, [:member_id, :canned_food_id], unique: :true
    # member_idとcanned_food_idの組み合わせが一意になるように(複合キー)設定
  end
end
