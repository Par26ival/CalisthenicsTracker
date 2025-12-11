class FixDefaultUsernames < ActiveRecord::Migration[7.2]
  def up
    User.where(username: "user").find_each do |u|
      # Example: make username based on email before '@'
      u.update(username: u.email.split("@").first.capitalize)
    end
  end
end
