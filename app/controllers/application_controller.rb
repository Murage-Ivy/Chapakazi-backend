class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, "My_s3cr3t")
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]

      begin
        JWT.decode(token, "My_s3cr3t", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      if decoded_token[0]["customer_id"]
        return current_customer
      elsif decoded_token[0]["handyman_id"]
        return current_handyman
      elsif decoded_token[0]["admin_id"]
        return current_admin
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { errors: ["Please log in!"] }, status: :unauthorized unless logged_in?
  end

  private

  def current_customer
    customer_id = decoded_token[0]["customer_id"]
    customer = Customer.find_by(id: customer_id)
  end

  def current_handyman
    handyman_id = decoded_token[0]["handyman_id"]
    handyman = Handyman.find_by(id: handyman_id)
  end

  def current_admin
    admin_id = decoded_token[0]["admin_id"]
    admin = Admin.find_by(id: admin_id)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
