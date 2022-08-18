class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :slot, null: false
      t.string :date, null: false
      t.integer :user_id
      t.integer :doctor_id

      t.timestamps
    end
  end
end
