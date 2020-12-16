class AddTimeZoneToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :time_zone, :string
  end
end
