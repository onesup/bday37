module ApplicationHelper
  def days_option_helper
    today = Time.now
    if Time.now.month == 4
      finish_of_this_month = 30
    else
      finish_of_this_month = 6
    end
    (today.day..finish_of_this_month).to_a
  end
  
  def days_helper(day)
    week_days = {0 => '월', 1 => '화', 2 => '수', 3 => '목', 4 => '금', 5 => '토', 6 => '일'}
    print_week_day = (DateTime.now-DateTime.now.wday+day).beginning_of_day.strftime('%Y-%m-%d')+"(일)"
    print_week_day
  end
  
  def months_option_helper
    today = Time.now
    (today.month..5).to_a
  end
end
