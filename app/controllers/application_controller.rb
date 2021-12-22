class ApplicationController < ActionController::API
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def render_bad_request(message)
    render json: { error: message }, status: :bad_request
  end
end
