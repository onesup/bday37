class Message < ActiveRecord::Base
  belongs_to :user
  def self.send_to(user)
    message = self.new
    message.user = user
    message.send_phone = Rails.application.secrets.send_phone
    message.dest_phone = user.phone 
    message.msg_body = self.send_message
    message.subject = "Skin Birthday"
    message.sent_at = Time.now + 5.seconds
    message.save!
    return message
  end
  
  def self.send_message
    "[Skin Birthday]
    생일을 축하드립니다!
    숨37 첫 구매 고객님께 
    피부생일 선물로 시크릿 프로그래밍 에센스(40ml)를 드립니다
    
    쿠폰받기:
    "
  end
  


end
