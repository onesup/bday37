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
  
  def days_helper(day)
    week_days = {0 => '월', 1 => '화', 2 => '수', 3 => '목', 4 => '금', 5 => '토', 6 => '일'}
    print_week_day = (DateTime.now-DateTime.now.wday+day).beginning_of_day.strftime('%Y-%m-%d')+"(일)"
    print_week_day
  end
  
  def months_option_helper
    today = Time.now
    # today = Date.parse("2014. 4. 2")
    (today.month..4).to_a
  end
  
  def week_paginate_next(current_page,link_path)
    link_to "다음주", eval(link_path+"("+(current_page.to_i-1).to_s+")")
  end

  def week_paginate_prev(current_page, link_path)
    link_to "지난주", eval(link_path+"("+(current_page.to_i+1).to_s+")")
  end
end
