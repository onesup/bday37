class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index
  end
end
