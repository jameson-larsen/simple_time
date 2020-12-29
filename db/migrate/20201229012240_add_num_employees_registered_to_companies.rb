class AddNumEmployeesRegisteredToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :num_employees_registered, :integer
  end
end
