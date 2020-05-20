require 'rails_helper'

RSpec.feature 'Navigation bar' do
  context 'public user' do
    it 'displays appropriate navbar links' do
      visit root_path
      expect(page).to have_link('Organizations', href: organizations_path)
      expect(page).to have_link('Activities', href: activities_path)
      expect(page).to have_link('Contact Us', href: new_contact_path)
      expect(page).to have_link('Sign In', href: new_user_session_path)
      expect(page).to_not have_link('Users', href: users_path)
      expect(page).to_not have_link(nil, href: /\/users\/[0-9]/) # User profile
      expect(page).to_not have_link('Sign Out')
    end
  end
  context 'guest user' do
    it 'displays appropriate navbar links' do
      user = create(:user)
      sign_in(user)
      visit root_path
      expect(page).to have_link('Organizations', href: organizations_path)
      expect(page).to have_link('Activities', href: activities_path)
      expect(page).to have_link('Contact Us', href: new_contact_path)
      expect(page).to have_link(user.to_s, href: user_path(user))
      expect(page).to have_link('Sign Out')
      expect(page).to_not have_link('Users', href: users_path)
      expect(page).to_not have_link('Sign In')
    end
  end
  context 'admin user' do
    it 'displays appropriate navbar links' do
      user = create(:user, :admin)
      sign_in(user)
      visit root_path
      expect(page).to have_link('Organizations', href: organizations_path)
      expect(page).to have_link('Activities', href: activities_path)
      expect(page).to have_link('Contact Us', href: new_contact_path)
      expect(page).to have_link('Users', href: users_path)
      expect(page).to have_link(user.to_s, href: user_path(user))
      expect(page).to have_link('Sign Out')
      expect(page).to_not have_link('Sign In')
    end
  end
end
