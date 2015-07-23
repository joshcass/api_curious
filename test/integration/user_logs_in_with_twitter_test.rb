require 'test_helper'

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = APICurious::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "josh",
          screen_name: "jc",
        }
      },
      credentials: {
        token: Figaro.env.sample_oauth_token,
        secret: Figaro.env.sample_oauth_secret
      }
    })
  end

  test 'logging in' do
    VCR.use_cassette("user-timeline") do
      visit '/'
      assert_equal 200, page.status_code
      click_link "Login With Twitter"
      assert page.has_css? ".tweet-box"
      assert page.has_css? ".tweet-list"
    end
  end
end
