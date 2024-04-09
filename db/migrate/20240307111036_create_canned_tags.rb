class CreateCannedTags < ActiveRecord::Migration[6.1]
  def change
    create_table :canned_tags do |t|
      t.integer :canned_food_id, null: false  # 缶詰ID
      t.integer :tag_id, null: false          # タグID

      t.timestamps
    end
  end
end
