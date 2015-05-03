class ErrorsController < ApplicationController
<<<<<<< HEAD
  include Gaffe::Errors


layout 'application'

=begin
=======
>>>>>>> 325fc3e7dce1deb28f5df017db7422bd42f6daad
  def file_not_found
    render :status => 404
  end

  def unprocessable
    render :status => 422
  end

  def internal_server_error
    render :status => 500
  end
<<<<<<< HEAD

  def show
        # Here, the `@exception` variable contains the original raised error
    render "errors/#{@rescue_response}", status: @status_code
  end
=end
=======
>>>>>>> 325fc3e7dce1deb28f5df017db7422bd42f6daad
end
