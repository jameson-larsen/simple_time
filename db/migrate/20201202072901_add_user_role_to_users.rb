class AddUserRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_role, :integer
  end
end
