# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User
  validates :profile, presence: true
  enum profile: { Admin: 0, Attendant: 1, Cooker: 2 }
end
