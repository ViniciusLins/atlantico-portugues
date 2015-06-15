require 'spec_helper'

describe "Errors Pages" do
  subject { page }

  describe "errors" do

    describe "GET 'file_not_found'" do
      it "returns http success" do
        visit "/1"
        page.should have_content(I18n.t('not_found'))
      end
    end

    RSpec.describe ApplicationController, :type => :controller do

      controller do
        def index
          render :text => "index called", :status => 500
        end
      end


      describe "GET 'internal_server_error''" do
        it "returns http success" do
          visit 'documents#index'
          DocumentsController.any_instance.stub(:index).and_raise(ArgumentError)
          response.code.should eq("200")
          #        response.body.should have_json_path("error")
        end
      end
    end

    RSpec.describe ApplicationController, :type => :controller do

      controller do
        def index
          render :text => "index called", :status => 422
        end
      end

      describe "GET 'unprocessable'" do
        it "returns http success" do
          response.code.should eq("200")
        end
      end
    end
  end

end
