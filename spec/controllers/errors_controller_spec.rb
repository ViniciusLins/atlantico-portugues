require 'spec_helper'

describe ErrorsController do

<<<<<<< HEAD
=======
  describe "GET 'file_not_found'" do
    it "returns http success" do
      get 'file_not_found'
      response.should be_success
    end
  end

  describe "GET 'unprocessable'" do
    it "returns http success" do
      get 'unprocessable'
      response.should be_success
    end
  end

  describe "GET 'internal_server_error'" do
    it "returns http success" do
      get 'internal_server_error'
      response.should be_success
    end
  end

>>>>>>> 325fc3e7dce1deb28f5df017db7422bd42f6daad
end
