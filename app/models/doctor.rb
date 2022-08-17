# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :name, presence: true
  validates :category, presence: true
  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments
end
