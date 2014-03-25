class WebSwitchController < ApplicationController
  def index
    referer = URI(request.referer || '').path
    Rails.logger.info "@@@@@referer: "+URI(request.env["HTTP_REFERER"] || '').path
    tracking_id = Rails.application.secrets.ga_tracking_id
    url = Rails.application.secrets.url
    g = Gabba::Gabba.new(tracking_id, url)
    g.referer(referer)
    g.page_view("pc/mobile switch page", "/")
    user_agent = UserAgent.parse(request.user_agent)
    if user_agent.mobile?
      device="mobile"
      @traffic_log = TrafficLog.new(ip: request.remote_ip, device: device, referer: referer)
      @traffic_log.save
      redirect_to mobile_index_path({s: params[:s]})
    else
      device="pc"
      @traffic_log = TrafficLog.new(ip: request.remote_ip, device: device, referer: referer)
      @traffic_log.save
      redirect_to pc_index_path({s: params[:s]})
    end
  end
end
