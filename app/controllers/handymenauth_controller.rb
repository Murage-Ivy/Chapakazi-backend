class HandymenauthController < ApplicationController
  skip_before_action :authorized
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    @handyman = Handyman.find_by(username: handyman_login_params[:username])
    if @handyman && @handyman.authenticate(handyman_login_params[:password])
      @token = encode_token({ handyman_id: @handyman.id })
      render json: { handyman: HandymanSerializer.new(@handyman), token: @token }, status: :accepted
    else
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  def handyman_login_params
    params.permit(:username, :password)
  end
end
