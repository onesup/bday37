class Admin::TrafficLogsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index
    @traffic_stats = TrafficLog.select("date(created_at) as created_date
    ,sum(case when source='lgh' then 1 else 0 end) as lgh_count
    ,sum(case when source='sum37' then 1 else 0 end) as sum37_count
    ,sum(case when source='lc' then 1 else 0 end) as lc_count
    ,sum(case when source='tw' then 1 else 0 end) as tw_count
    ,sum(case when source='fb' then 1 else 0 end) as fb_count
    ,sum(case when source='sw' then 1 else 0 end) as sw_count
    ,sum(case when source='ks' then 1 else 0 end) as ks_count
    ,sum(case when source='kt' then 1 else 0 end) as kt_count
    ,sum(case when source='fbapp' then 1 else 0 end) as fbapp_count
    ,sum(case when source='page' then 1 else 0 end) as page_count
    ,sum(case when source not in ('lgh','sum37','lc','tw','fb','sw','ks','kt','fbapp','page') then 1 else 0 end) as etc_count
    ,count(*) as total_count").group("date(created_at)").order("date(created_at)")
    @traffic_stats_sum = TrafficLog.select("
     sum(case when source='lgh' then 1 else 0 end) as lgh_count
    ,sum(case when source='sum37' then 1 else 0 end) as sum37_count
    ,sum(case when source='lc' then 1 else 0 end) as lc_count
    ,sum(case when source='tw' then 1 else 0 end) as tw_count
    ,sum(case when source='fb' then 1 else 0 end) as fb_count
    ,sum(case when source='sw' then 1 else 0 end) as sw_count
    ,sum(case when source='ks' then 1 else 0 end) as ks_count
    ,sum(case when source='kt' then 1 else 0 end) as kt_count
    ,sum(case when source='fbapp' then 1 else 0 end) as fbapp_count
    ,sum(case when source='page' then 1 else 0 end) as page_count
    ,sum(case when source not in ('lgh','sum37','lc','tw','fb','sw','ks','kt','fbapp','page') then 1 else 0 end) as etc_count
    ,count(*) as total_count")
    
    # @event_stats = @traffic_stats.joins(@viral_stats).where(@traffic_stats.create_date => @viral_stats.created)
  end
end
