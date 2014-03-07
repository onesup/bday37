class WebSwitchController < ApplicationController
  def index
    # tracking_id = Rails.application.secrets.ga_tracking_id
    # url = Rails.application.secrets.url
    # Gabba::Gabba.new(tracking_id, url).page_view("pc/mobile switch page", "/")
    user_agent = UserAgent.parse(request.user_agent)
    if user_agent.mobile?
      redirect_to mobile_index_path({s: params[:s]})
    else
      redirect_to pc_index_path({s: params[:s]})
    end
  end
end
