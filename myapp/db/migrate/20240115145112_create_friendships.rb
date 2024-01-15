class CreateFriendships < ActiveRecord::Migration[7.1]
  def change
    create_table :friendships do |t|
      t.integer :user_source_id, null: false
      t.integer :user_destine_id, null: false
      t.index [:user_source_id, :user_destine_id], unique: true

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :user_source_id
    add_foreign_key :friendships, :users, column: :user_destine_id
  end
end
