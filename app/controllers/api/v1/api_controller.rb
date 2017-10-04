module Api
  module V1
    class APIController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_api_user!
    end
  end
end