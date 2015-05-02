require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "rails/all"
# require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_view/railtie"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-BR'

    config.exceptions_app = self.routes
    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true
 
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Exception, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def raise_not_found
    raise ActionController::RoutingError.new("No route matche #{params[:unmatched_route]}")
  end

  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/errors/file_not_found.html.erb", :layout => false, :status => :not_found }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def error
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/500", :layout => false, :status => :error }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  end
end
