class Api::V1::HealthCheckController < ActionController::API
  def index
    render json: { status: 'ok' }, status: :ok
  end
end
