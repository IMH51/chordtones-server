class ApplicationController < ActionController::API

  def get_current_user
    id = decode_token['id']
    User.find_by(id: id)
  end

  def decode_token
    token = get_token
    begin
      JWT.decode(token, secret).first
    rescue
      { error: 'Invalid.' }
    end
  end

  def get_token
    request.headers['Authorization']
  end

  def issue_token(data)
    JWT.encode(data, secret)
  end

  def secret
    ENV['SECRET']
  end
end