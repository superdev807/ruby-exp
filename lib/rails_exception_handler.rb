class RailsExceptionHandler

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue Exception => e
    Handler.new(env, e).handle_exception
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
    return unless configuration.activate?

    Rails.configuration.middleware.use(RailsExceptionHandler)

    Rails.configuration.action_dispatch.show_exceptions = true
    Rails.configuration.consider_all_requests_local = false
    require File.expand_path(File.dirname(__FILE__)) + '/patch/show_exceptions.rb'
    configuration.run_callback
  end
end

require 'rails_exception_handler/configuration.rb'
require 'rails_exception_handler/handler.rb'
require 'rails_exception_handler/parser.rb'
require 'rails_exception_handler/engine.rb'
require 'net/http'
