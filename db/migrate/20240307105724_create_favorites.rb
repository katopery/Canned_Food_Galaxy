class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :member_id, null: false       #会員ID
      t.integer :canned_food_id, null: false  #缶詰ID

      t.timestamps
    end
  end
end
