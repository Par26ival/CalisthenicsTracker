class CreateFriendships < ActiveRecord::Migration[7.2]
  def change
    create_table :friendships do |t|
      t.integer :requester_id, null: false
      t.integer :receiver_id, null: false
      t.string  :status, null: false, default: "pending"

      t.timestamps
    end

    add_index :friendships, [:requester_id, :receiver_id], unique: true
  end
end
