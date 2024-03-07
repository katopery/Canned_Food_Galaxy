class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :member_id, null: false           #会員ID
      t.integer :canned_food_id, null: false      #缶詰ID
      t.integer :expiry_date_rating, null: false  #賞味期限評価
      t.integer :taste_rating, null: false        #味評価
      t.integer :snack_rating, null: false        #お酒に合う度（おつまみ）
      t.integer :outdoor_rating, null: false      #アウトドア評価

      t.timestamps
    end
  end
end
