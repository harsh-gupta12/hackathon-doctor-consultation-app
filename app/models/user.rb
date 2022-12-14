# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :mobile, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
end
