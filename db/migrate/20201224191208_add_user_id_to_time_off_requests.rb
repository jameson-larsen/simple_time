class AddUserIdToTimeOffRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :time_off_requests, :user_id, :integer
  end
end
