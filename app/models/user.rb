class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    if user = find_by(uid: auth_info.extra.raw_info.id_str)
      user
    else
      user = create({name: auth_info.extra.raw_info.name,
        screen_name: auth_info.extra.raw_info.screen_name,
        uid: auth_info.extra.raw_info.id_str,
        oauth_token: auth_info.credentials.token,
        oauth_token_secret: auth_info.credentials.secret
      })
      user
    end
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
      config.access_token = oauth_token
      config.access_token_secret = oauth_token_secret
    end
  end

  def twitter_timeline
    @twitter_timeline ||= twitter_client.home_timeline
  end

  def info
    @info ||= twitter_client.user
  end
end
