class CreateTimeOffRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :time_off_requests do |t|
      t.timestamp :start
      t.timestamp :end

      t.timestamps
    end
  end
end
