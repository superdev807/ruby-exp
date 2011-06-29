class ExceptionHandler::Handler
  def initialize(env, exception)
    @exception = exception
    @env = env
  end

  def handle_exception
    controller = @env['action_controller.instance']
    request = ActionDispatch::Request.new(@env)
    parsed_error = Parser.new(@exception, request, controller)
    ErrorMessage.create(parsed_error.relevant_info) unless(parsed_error.ignore?)
    log_error(parsed_error.relevant_info)
    return response
  end
  
  def log_error(info)
    message = "#{info[:class_name]} (#{info[:message]}):\n  "
    message += Rails.backtrace_cleaner.clean(info[:trace].split("\n")).join("\n")
    Rails.logger.fatal(message)
  end

  def response
    ErrorResponseController.action(:index).call(@env)
  end
end
