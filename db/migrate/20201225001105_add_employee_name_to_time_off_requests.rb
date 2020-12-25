class AddEmployeeNameToTimeOffRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :time_off_requests, :employee_name, :string
  end
end
