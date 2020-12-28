class AddPasswordChangedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_changed, :integer
  end
end
