class User < ActiveRecord::Base
  has_many :messages
  validates :name, presence: true
  validates :phone, presence: true
  validates :birthday, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable # :registerable
  # dragonfly_accessor :last_sign_in_ip
  # image_accessor :last_sign_in_ip
end
