class StaticPagesController < ApplicationController
    def home
      @page = Page.find_by_title("Home")
    end

    def help
    end

    def about
    end

    def contact
    end

    def search
      @documents = Document.search(params[:search]).page(params[:page])
    end
end
