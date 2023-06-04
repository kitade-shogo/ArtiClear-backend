class Api::V1::BaseController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Api::ExceptionHandler
  include FirebaseAuth

  before_action :authenticate_token

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      
    begin
      result = verify_id_token(token)
    rescue => e
      logger.error "Failed to verify token: #{e.message}"
      return
    end

      if result[:errors]
        render_400(nil, result[:errors])
      else
        @current_user = User.find_or_create_by!(uid: result[:uid])
      end
    end
  end

  def current_user
    @current_user
  end

end
