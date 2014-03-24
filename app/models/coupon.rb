class Coupon < ActiveRecord::Base
  belongs_to :user
  
  def send_message
    Message.send_to(self)
  end
  
  def random_code
    alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z) * 3
    digit = %w(1 2 3 4 5 6 7 8 9 0) * 2
    code = alphabet.shuffle.join[0..4] + "-" + digit.shuffle.join[0..3]
    code
  end
  
  def is_used?
    if status == "used"
      return "used"
      
    elsif status == "not_used"
      return "not_used"

    end
  end

  def confirm
    status = "used"
    used_at = Time.now
    self.save
  end



end
