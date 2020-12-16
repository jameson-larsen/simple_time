class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.timestamp :start
      t.timestamp :end
      t.float :duration

      t.timestamps
    end
  end
end
