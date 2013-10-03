class ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :json

  rescue_from Exception do |exception|
    status = case exception.class
    when ActionController::ParameterMissing
      400
    when ActiveRecord::RecordNotFound
      404
    else
      500
    end

    render json: exception, status: status
  end
end
