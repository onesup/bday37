class User < ActiveRecord::Base
  has_many :messages
  has_many :access_logs
  has_one :coupon
  validates :agree, acceptance: true
  validates :agree2, acceptance: true
  validates :name, presence: true
  validates :phone, presence: true
  validates :phone, uniqueness: true
  validates :birthday, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable # :registerable
  # dragonfly_accessor :last_sign_in_ip
  # image_accessor :last_sign_in_ip
end
