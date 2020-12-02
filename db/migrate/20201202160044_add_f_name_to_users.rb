class AddFNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :f_name, :string
  end
end
