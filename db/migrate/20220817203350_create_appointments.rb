class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :slot, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
