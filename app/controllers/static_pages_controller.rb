class StaticPagesController < ApplicationController
    def home
      @page = Page.find_by_title(I18n.t('home'))
    end

    def help
    end

    def about
    end

    def contact
    end

end
