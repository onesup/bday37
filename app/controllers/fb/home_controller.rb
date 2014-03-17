class Fb::HomeController < ApplicationController
  layout 'facebook'
  skip_before_action :verify_authenticity_token
  def create
    app_id = Rails.application.secrets.fb_app_id
    app_secret = Rails.application.secrets.fb_app_secret
    oauth = Koala::Facebook::OAuth.new(app_id, app_secret)
    begin
      request = oauth.parse_signed_request(params["signed_request"])
      result = request["page"]["liked"]
      Rails.logger.info request
    rescue
      result = "invalid!!!"
    end
    redirect_to pc_index_path, :protocol => "http://"
  end
  
  def index
    @user = User.new
  end
end
