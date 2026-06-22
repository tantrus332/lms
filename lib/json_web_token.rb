class JsonWebToken
  SECRET_KEY = ENV.fetch("JWT_SECRET") { Rails.application.secret_key_base }
  EXPIRATION = 24.hours

  def self.encode(payload)
    payload[:exp] = EXPIRATION.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end
end
