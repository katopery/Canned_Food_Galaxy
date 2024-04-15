class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :member_id, null: false # 会員ID
      t.integer :review_id, null: false # レビューID
      t.text :content, null: false      # コメント内容

      t.timestamps
    end
  end
end
