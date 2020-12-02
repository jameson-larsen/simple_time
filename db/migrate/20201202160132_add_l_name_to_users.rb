class AddLNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :l_name, :string
  end
end
