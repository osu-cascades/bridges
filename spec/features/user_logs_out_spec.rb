require 'rails_helper'

RSpec.feature 'User logs out' do
  context 'when logged in' do
    let(:user) { create(:user) }
    before { sign_in(user) }

    scenario 'successfully logs out' do
      visit root_path
      expect(page).to have_no_link 'Sign In'
      expect(page).to have_link 'Sign Out'
      click_link 'Sign Out'
      expect(page).to have_no_link 'Sign Out'
      expect(page).to have_link 'Sign In'
      expect(page).to have_selector '.alert', text: 'Signed out successfully.'
    end
  end
end
