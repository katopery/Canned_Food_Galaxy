class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :member, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.text :content, null: false  # メッセージ内容

      t.timestamps
    end
  end
end
