class AddStatusToTimeOffRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :time_off_requests, :status, :integer
  end
end
