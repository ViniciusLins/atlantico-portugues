class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_locale
   
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Exception, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def not_found
    respond_to do |format|
#      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
#      format.html { render :file => "/errors/file_not_found", :layout => false, :status => :not_found }
      format.html { render "/errors/file_not_found" }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def error
    respond_to do |format|
      format.html { render "/errors/internal_server_error" }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def error
    respond_to do |format|
      format.html { render "/errors/unprocessable" }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end



end
