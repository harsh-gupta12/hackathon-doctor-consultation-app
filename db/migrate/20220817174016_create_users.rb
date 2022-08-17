# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false, unique: true
      t.string :password_digest
      t.string :mobile, null: false, unique: true
      t.string :email, null: false
      t.date :dob
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
