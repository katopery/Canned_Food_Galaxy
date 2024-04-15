class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :canned_tag_id, null: false # 缶詰タグID
      t.string :name, null: false           # タグ名

      t.timestamps
    end
  end
end
