class AddRegistrationTokenToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :registration_token, :string
  end
end
