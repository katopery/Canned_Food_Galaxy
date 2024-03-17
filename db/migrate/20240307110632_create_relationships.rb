class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false #フォローする会員ID
      t.integer :followed_id, null: false #フォローされる会員ID

      t.timestamps
    end
  end
end
