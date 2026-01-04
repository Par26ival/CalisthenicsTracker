class AddTimeoutUntilToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :timeout_until, :datetime
  end
end
