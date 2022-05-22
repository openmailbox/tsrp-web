class User < ApplicationRecord
  has_many :authorizations

  def self.find_or_create_from_auth(data)
    auth = Authorization.find_by(provider: data.provider, uid: data.uid)
    return auth.user if auth

    new_auth = Authorization.new(
      expires_at:    data.dig(:credentials, :expires_at),
      token:         data.dig(:credentials, :token),
      refresh_token: data.dig(:credentials, :refresh_token),
      provider:      data.provider,
      name:          data.dig(:info, :name),
      email:         data.dig(:info, :email),
      image_url:     data.dig(:info, :image),
      uid:           data.uid
    )

    # Maybe this is a new auth method for an existing user
    new_auth.user = new_auth.email && Authorization.find_by(email: new_auth.email)&.user

    unless new_auth.can_register? then
      new_auth.user ||= User.new(email: new_auth.email, name: new_auth.name)
      new_auth.user.errors.add(:base, "You must join the Discord before registering.")
      return new_auth.user
    end

    # If we're here, this is a new user
    new_auth.user ||= User.create(email: new_auth.email, name: new_auth.name)
    new_auth.save

    return new_auth.user
  end
end
