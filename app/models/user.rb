class User < ActiveRecord::Base
  def self.create_with_omniauth_facebook(auth)
    create! do |user|
      user.facebook_id = auth["uid"]
      user.facebook_token = auth["credentials"]["token"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar = auth["info"]["image"]
    end
  end
end
