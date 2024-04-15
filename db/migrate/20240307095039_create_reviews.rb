class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :member_id, null: false, default: 0           # 会員ID
      t.integer :canned_food_id, null: false, default: 0      # 缶詰ID
      t.integer :expiry_date_rating, null: false, default: 0  # 賞味期限評価
      t.integer :taste_rating, null: false, default: 0        # 味評価
      t.integer :snack_rating, null: false, default: 0        # お酒に合う度（おつまみ）
      t.integer :outdoor_rating, null: false, default: 0      # アウトドア評価

      t.timestamps
    end
  end
end
