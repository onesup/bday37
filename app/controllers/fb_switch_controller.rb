class FbSwitchController < ApplicationController
  def index
    user_agent = UserAgent.parse(request.user_agent)
    if user_agent.mobile?
      device="mobile"
      @traffic_log = TrafficLog.new(ip: request.remote_ip, device: device)
      @traffic_log.save
      redirect_to mobile_index_path({s: params[:s]})
    else
      device="pc"
      s = params[:s] || ""
      @traffic_log = TrafficLog.new(ip: request.remote_ip, device: device)
      @traffic_log.save
      redirect_to Rails.application.secrets.page_tab_address+"&s="+ s
    end
  end
end
