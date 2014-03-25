class Message < ActiveRecord::Base
  belongs_to :user
  has_one :coupon
  
  def self.send_to(coupon)
    message = self.new
    message.send_phone = Rails.application.secrets.send_phone
    message.dest_phone = coupon.user.phone 
    message.msg_body = self.send_message(coupon)
    message.subject = "Skin Birthday"
    message.send_name = coupon.user.name
    message.sent_at = Time.now + 5.seconds
    message.save
    message.user = coupon.user
    message.coupon = coupon
    message.save
    message.send_lms
    return message
  end
  
  def self.send_message(coupon)
    "
"+coupon.user.name+"님
피부생일을 축하드려요!
시크릿 프로그래밍 에센스 
40ml 선물을 드립니다.
지금 받으러가요!
- 본 행사는 숨37 
첫 구매고객 대상 행사로 
기존 구매고객은 
제외됩니다.

쿠폰받기:" + Rails.application.secrets.url + "/" + coupon.code +
"

모바일 쿠폰 사용 유의사항
· 숨37 멤버십에 가입하셔야 혜택을 누리실 수 있습니다.
· 전국 백화점 매장에서만 사용 가능합니다.
· 쿠폰은 한정수량으로 조기 소진될 수 있으며 1인 1회로 한정되어 있습니다.
"

  end
  
  def send_lms
    url = "http://api.openapi.io/ppurio/1/message/lms/minivertising"
    api_key = Rails.application.secrets.apistore_key
    time = (Time.now + 1.seconds)
    res = RestClient.post(url,
      {
        "send_time" => time.strftime("%Y%m%d%H%M%S"), 
        "dest_phone" => self.dest_phone, 
        "dest_name" => "LG",
        "send_phone" => self.send_phone, 
        "send_name" => self.send_name,
        "subject" => self.subject,
        "apiVersion" => "1",
        "id" => "minivertising",
        "msg_body" => self.msg_body
      },
      content_type: 'multipart/form-data',
      'x-waple-authorization' => api_key
    )
    parsed_result = JSON.parse(res)
    cmid = parsed_result["cmid"]
    call_status = String.new
    start = Time.new
    during_time = 0
    return JSON.parse(res)
    # while call_status.empty? or call_status == "result is null" or during_time < 3.minutes
    #   sleep(10.seconds)
    #   call_status = report(cmid, time)
    #   during_time = Time.now - start
    # end
  end
  
  def waiting_for_result(interval_time, finish_time)
    start_time = Time.now
    during_time = Time.now - start_time
    result = false
    while finish_time > during_time
      during_time = Time.now - start_time
      sleep(interval_time)
    end
    if finish_time < during_time
      result = true
    end
    return result
  end
  
  def report(cmid, time)
    api_key = Rails.application.secrets.apistore_key
    url = "http://api.openapi.io/ppurio/1/message/report/minivertising?cmid="+cmid
    result = RestClient.get(url, 'x-waple-authorization' => api_key)
    call_status = JSON.parse(result)["call_status"].to_s
    self.sent_at = time
    self.cmid = cmid
    self.result = result
    self.call_status = call_status
    self.save!    
    return call_status
  end
  

end
