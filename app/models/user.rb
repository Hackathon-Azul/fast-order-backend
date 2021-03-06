# frozen_string_literal: true

class User < ActiveRecord::Base
  include LikeSearchable
  include Paginatable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User
  
  has_many :orders

  validates :name, presence: true
  enum profile: { Admin: 0, Attendant: 1, Cooker: 2 }
end
