class ErrorsController < ApplicationController
  include Gaffe::Errors


layout 'application'

=begin
  def file_not_found
    render :status => 404
  end

  def unprocessable
    render :status => 422
  end

  def internal_server_error
    render :status => 500
  end

  def show
        # Here, the `@exception` variable contains the original raised error
    render "errors/#{@rescue_response}", status: @status_code
  end
=end
end
