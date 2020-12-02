class CreatePunches < ActiveRecord::Migration[6.0]
  def change
    create_table :punches do |t|
      t.timestamp :in
      t.timestamp :out
      t.float :duration

      t.timestamps
    end
  end
end
