class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index
    @traffic_stats = TrafficLog.select("date(created_at) as created_date,sum(case when device='pc' then 1 else 0 end) as pc_count, sum(case when device='mobile' then 1 else 0 end) as mobile_count").group("date(created_at)").order("date(created_at)")
    @traffic_stats_sum = TrafficLog.select("sum(case when device='pc' then 1 else 0 end) as pc_count, sum(case when device='mobile' then 1 else 0 end) as mobile_count")
    @viral_stats = ViralAction.select("date(created_at) as created_date,count(*) as viral_count").group("date(created_at)").order("created_at")
    @viral_stats_sum = ViralAction.select("count(*) as viral_count")
    @user_stats = User.joins(:coupon).select("date(users.created_at) as created_date,sum(case when device='pc' then 1 else 0 end) as pc_count, sum(case when device='mobile' then 1 else 0 end) as mobile_count, sum(case when coupons.status='used' then 1 else 0 end) as coupon_user_count").group("date(created_at)").order("date(created_at)")
    @user_stats_sum = User.joins(:coupon).select("sum(case when device='pc' then 1 else 0 end) as pc_count, sum(case when device='mobile' then 1 else 0 end) as mobile_count, sum(case when coupons.status='used' then 1 else 0 end) as coupon_user_count")
    
    # @event_stats = @traffic_stats.joins(@viral_stats).where(@traffic_stats.create_date => @viral_stats.created)
  end
end
