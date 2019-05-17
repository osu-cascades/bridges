require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'redirect when admin not signed in' do
    get users_path
    assert_redirected_to new_user_session_path
  end
end
