class ApplicationController < ActionController::API
  # run this function before hitting any routes in the controller
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    # if token is not null
    if decoded_token
      # get user id and decode the token
      user_id = decoded_token[0]['user_id']
      # looks for user and assigns it to the property
      @user = User.find_by(id: user_id)
    end
  end

  #returns a boolean based on what logged_in_user returns
  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
