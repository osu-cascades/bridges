require 'rails_helper'

RSpec.describe 'layouts/_navbar.html.haml' do
  it 'displays navbar links' do
    render

    expect(rendered).to have_link('Bridges', href: root_url)
    expect(rendered).to have_link('Organizations', href: organizations_path)
    expect(rendered).to have_link('Activities', href: activities_path)
    expect(rendered).to have_link('Contact Us', href: new_contact_path)
    expect(rendered).to_not have_link('Users', href: users_path)
    expect(rendered).to have_link('Sign In', href: new_user_session_path)
  end

  it 'displays user links when signed in and admin' do
    user = create(:user, :admin)
    allow(view).to receive(:current_user) { user }
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:signed_in?).and_return(true)

    render

    expect(rendered).to have_link('Bridges', href: root_url)
    expect(rendered).to have_link('Organizations', href: organizations_path)
    expect(rendered).to have_link('Activities', href: activities_path)
    expect(rendered).to have_link('Contact Us', href: new_contact_path)
    expect(rendered).to have_link('Users', href: users_path)
    expect(rendered).to have_link(user.to_s, href: "/users/#{user.id}")
    expect(rendered).to have_link('Sign Out', href: destroy_user_session_path)
  end
end
