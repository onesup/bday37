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
  
  def self.coupon_used_counts
    result = User.select("
      date(convert_tz(coupons.updated_at,'+00:00','+09:00')) used_date,
      count(*) used_count ")
      .joins(:coupon)
      .where(coupons:{status: "used"})
      .group("date(convert_tz(coupons.updated_at,'+00:00','+09:00'))")
      .order("coupons.updated_at")
  end
  
  def self.coupon_used_users
    result = User.includes(:coupon)
      .where(coupons: {status: "used"})
      .order("coupons.updated_at DESC")
  end
  
  def self.count_by_device_type
    result = self.select(
      "sum(case when users.device = 'pc' then 1 else 0 end) as pc_count, 
      sum(case when users.device = 'mobile' then 1 else 0 end) as mobile_count, 
      count(*) as total_count")
  end
end
