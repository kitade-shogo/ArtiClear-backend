class Api::V1::AuthenticationsController < Api::V1::BaseController
  def create
    render json: { message: "User Logged In Successfully" } if current_user
  end
end
