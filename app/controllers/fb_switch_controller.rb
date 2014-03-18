class FbSwitchController < ApplicationController
  def index
    user_agent = UserAgent.parse(request.user_agent)
    if user_agent.mobile?
      redirect_to mobile_index_path({s: params[:s]})
    else
      redirect_to Rails.application.secrets.page_tab_address
    end
  end
end
