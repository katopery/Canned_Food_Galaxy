class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :member_id, null: false   #会員ID
      t.integer :followed_id, null: false #フォローされる会員ID

      t.timestamps
    end
  end
end
