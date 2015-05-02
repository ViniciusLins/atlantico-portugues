class StaticPagesController < ApplicationController
    def home
      @page = Page.find_by_title(I18n.t('home_page'))
    end

    def help
      @page = Page.find_by_title(I18n.t('help_page'))
    end

    def about
      @page = Page.find_by_title(I18n.t('about_page'))
    end

    def contact
      @page = Page.find_by_title(I18n.t('contact_page'))
    end

    def notFound
      @page='notFound'
    end

end
