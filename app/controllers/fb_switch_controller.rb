class FbSwitchController < ApplicationController
  def index
    if request.referer.nil?
      referer = "-"
    else
      referer = URI(request.referer || '').scheme + "://" + URI(request.referer || '').host 
    end
    session[:referer] = request.referer
    Rails.logger.info "@@@@@referer: " + referer
    tracking_id = Rails.application.secrets.ga_tracking_id
    url = Rails.application.secrets.url
    # g = Gabba::Gabba.new(tracking_id, url)
    # g.referer(request.referer)
    # g.page_view("fb/mobile switch page", "/")    
    user_agent = UserAgent.parse(request.user_agent)
    source = params[:s] || "-"
    if user_agent.mobile?
      device = "mobile"
      @traffic_log = TrafficLog.new
      @traffic_log.ip = request.remote_ip 
      @traffic_log.device = device
      @traffic_log.referer = referer
      @traffic_log.source = source
      @traffic_log.save
      redirect_to mobile_index_path({s: params[:s]})
    else
      device = "pc"
      s = params[:s] || ""
      @traffic_log = TrafficLog.new
      @traffic_log.ip = request.remote_ip 
      @traffic_log.device = device
      @traffic_log.referer = referer
      @traffic_log.source = source
      @traffic_log.save
      redirect_to Rails.application.secrets.page_tab_address
    end
  end
end
