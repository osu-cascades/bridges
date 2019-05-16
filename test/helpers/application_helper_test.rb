require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def signed_in?
    @signed_in
  end

  test 'displays sign in link when user is not logged in' do
    @signed_in = false
    assert_match 'Sign In', sign_in_or_out_link
  end

  test 'displays sign out link when user is logged in' do
    @signed_in = true
    assert_match 'Sign Out', sign_in_or_out_link
  end

end
