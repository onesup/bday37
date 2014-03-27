module ApplicationHelper
  def days_option_helper
    today = Time.now
    # today = Date.parse("2014. 4. 2")
    if Time.now.month == 3
      finish_of_this_month = 31 
    else
      finish_of_this_month = 27
    end
    (today.day..finish_of_this_month).to_a
  end
  
  def months_option_helper
    today = Time.now
    # today = Date.parse("2014. 4. 2")
    (today.month..4).to_a
  end
end
