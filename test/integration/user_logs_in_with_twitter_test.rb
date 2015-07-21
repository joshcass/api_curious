require 'test_helper'

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = ::Application
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
        token: "pizza",
        secret: "secretpizza"
      }
    })
  end

  test 'logging in' do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login"
    assert_equal "/", current_path
    assert page.has_content?("josh")
    assert page.has_link?("Logout")
  end
end
