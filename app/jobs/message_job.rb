class MessageJob
  include SuckerPunch::Job

  def perform(coupon)
    Message.send_to(coupon)
  end
  
  # def later(sec, message, send_message, dest)
  #   after(sec) { perform(message, send_message, dest) }
  # end
end