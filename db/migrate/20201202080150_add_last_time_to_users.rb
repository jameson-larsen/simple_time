class AddLastTimeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_time, :timestamp
  end
end
