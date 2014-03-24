class Admin::ViralActionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @viral_actions = ViralAction.order("id desc").page(params[:page]).per(200)
  end
end
