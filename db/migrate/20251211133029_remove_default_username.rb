class RemoveDefaultUsername < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :username, nil
  end
end
