class Admin::ViralActionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @viral_actions = ViralAction.order("id desc").page(params[:page]).per(200)
    @viral_action_counts_daily = ViralAction.select(
      "date(viral_actions.created_at) as created_date,
      sum(case when viral_actions.device = 'pc' then 1 else 0 end) as pc_count,
      sum(case when viral_actions.device = 'mobie' then 1 else 0 end) as mobile_count,
      count(*) as total_count")
        .group("date(viral_actions.created_at)")
        .order("date(viral_actions.created_at)")
    @viral_action_counts_sum = ViralAction.select(
      "sum(case when viral_actions.device = 'pc' then 1 else 0 end) as pc_count,
      sum(case when viral_actions.device = 'mobile' then 1 else 0 end) as mobile_count, 
      count(*) as total_count")
    @viral_platform_counts_daily = ViralAction.select(
      "date(viral_actions.created_at) as created_date,
      sum(case when viral_actions.platform = 'facebook' then 1 else 0 end) as facebook_count, 
    	sum(case when viral_actions.platform = 'twitter' then 1 else 0 end) as twitter_count, 
    	sum(case when viral_actions.platform = 'kakaostory' then 1 else 0 end) as kakaostory_count, 
    	sum(case when viral_actions.platform = 'kakaotalk' then 1 else 0 end) as kakaotalk_count, 
      sum(case when viral_actions.platform = 'blog' then 1 else 0 end) as blog_count, 
    	count(*) as total_count")
        .group("date(viral_actions.created_at)")
        .order("date(viral_actions.created_at)")
    @viral_platform_counts_sum = ViralAction.select(
      "sum(case when viral_actions.platform = 'facebook' then 1 else 0 end) as facebook_count, 
      sum(case when viral_actions.platform = 'twitter' then 1 else 0 end) as twitter_count, 
      sum(case when viral_actions.platform = 'kakaostory' then 1 else 0 end) as kakaostory_count, 
      sum(case when viral_actions.platform = 'kakaotalk' then 1 else 0 end) as kakaotalk_count, 
      sum(case when viral_actions.platform = 'blog' then 1 else 0 end) as blog_count, 
      count(*) as total_count") 
  end
end
