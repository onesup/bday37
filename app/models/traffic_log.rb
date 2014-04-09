class TrafficLog < ActiveRecord::Base
  
  def self.pagenate_by_week(page)
    page ||= 1 
    page = page.to_i
    start_date = (DateTime.now-DateTime.now.wday-7*(page-1)).beginning_of_day
    end_date = (DateTime.now+(7-DateTime.now.wday)-7*(page-1)).beginning_of_day
    self.source_by_weekday(start_date,end_date)
  end
  
  def self.source_by_weekday(start_date, end_date)
    self.select("source
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 1 then 1 else 0 end) as 'sun'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 2 then 1 else 0 end) as 'mon'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 3 then 1 else 0 end) as 'tue'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 4 then 1 else 0 end) as 'wed'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 5 then 1 else 0 end) as 'thu'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 6 then 1 else 0 end) as 'fri'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 7 then 1 else 0 end) as 'sat' ")
        .where("created_at >= ? and created_at < ?", start_date, end_date)
        .group("source").order("source")
  end
  
  def self.pagenate_by_week_sum(page)
    page ||= 1 
    page = page.to_i
    start_date = (DateTime.now-DateTime.now.wday-7*(page-1)).beginning_of_day
    end_date = (DateTime.now+(7-DateTime.now.wday)-7*(page-1)).beginning_of_day
    self.source_by_weekday_sum(start_date,end_date)
  end
  
  def self.source_by_weekday_sum(start_date,end_date)
    self.select(
      "sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 1 then 1 else 0 end) as 'sun'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 2 then 1 else 0 end) as 'mon'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 3 then 1 else 0 end) as 'tue'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 4 then 1 else 0 end) as 'wed'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 5 then 1 else 0 end) as 'thu'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 6 then 1 else 0 end) as 'fri'
      ,sum(case when DayofWeek(convert_tz(created_at,'+00:00','+09:00')) = 7 then 1 else 0 end) as 'sat' ")
        .where("created_at >= ? and created_at < ?", start_date, end_date)
  end
end
