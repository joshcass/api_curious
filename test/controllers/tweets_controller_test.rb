require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: "Josh",
      screen_name: "devjoshdev",
      uid: "12345",
      oauth_token: Figaro.env.sample_oauth_token,
      oauth_token_secret: Figaro.env.sample_oauth_secret)
    session[:user_id] = @user.id
  end

  test 'creates a tweet on #create' do
    VCR.use_cassette('create_tweet') do
      post :create, tweet: {status: "Hello World"}

      assert_response :redirect
      assert_select ".tweet-box"
    end
  end
end
