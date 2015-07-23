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
      assert_redirected_to user_path(@user.id)
    end
  end

  test 'favorites a tweet on #favorite' do
    VCR.use_cassette('favorite_tweet') do
      post :favorite, id: "624270020214964224"

      assert_response :redirect
      assert_redirected_to user_path(@user.id)
    end
  end

  test 'unfavorites a tweet on #unfavorite' do
    VCR.use_cassette('unfavorite_tweet') do
      post :unfavorite, id: "624270020214964224"

      assert_response :redirect
      assert_redirected_to user_path(@user.id)
    end
  end

  test 'retweets a tweet on #retweet' do
    VCR.use_cassette('retweet_tweet') do
      post :retweet, id: "624270020214964224"

      assert_response :redirect
      assert_redirected_to user_path(@user.id)
    end
  end

  test 'replies to a tweet on #reply' do
    VCR.use_cassette('reply_tweet') do
      post :reply, tweet: {status: "@Reuters Great!", tweet_id: "624270020214964224"}

      assert_response :redirect
      assert_redirected_to user_path(@user.id)
    end
  end

  test 'searches for tweets on #search' do
    VCR.use_cassette('search_tweet') do
      post :search, tweet: {query: "@joshcass"}

      assert_response :success
      assert_not_nil :search_results
    end
  end

  test 'it fetches tweets on #refresh' do
    VCR.use_cassette('refresh_tweets') do
      get :refresh, id: "624270020214964224"

      assert_response :success
      assert_not_nil :tweets
    end
  end

  test 'it fetches tweets on #load_more' do
    VCR.use_cassette('load_more') do
      get :load_more, id: "624270020214964224"

      assert_response :success
      assert_not_nil :tweets
    end
  end
end
