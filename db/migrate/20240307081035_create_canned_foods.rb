class CreateCannedFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :canned_foods do |t|
      t.string :canned_name, null: false                      # 缶詰名
      t.text :description, null: false                        # 缶詰説明
      t.boolean :is_canned_status, null: false, default: true # 缶詰表示ステータス true:表示する、false:表示しない

      t.timestamps
    end
  end
end
