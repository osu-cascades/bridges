require 'rails_helper'

RSpec.feature 'Requesting contact' do
  before do
    @organization = create(:organization)
    ActionMailer::Base.deliveries.clear
    visit new_contact_path
  end

  scenario 'successfully, with valid form completion' do
    select @organization.name, from: 'contact[to]'
    fill_in 'Name', with: 'Hannah Montana'
    fill_in 'Email', with: 'hmontana@example.com'
    fill_in 'Message', with: "TOP SECRET: I'm actually Miley Cyrus with a wig on"
    click_on 'Submit'
    expect(page).to have_content('Thank you, your message has been sent.')
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq('Bridges Contact Request')
  end

  scenario 'failure, with invalid form completion' do
    fill_in 'Name', with: ''
    fill_in 'Email', with: ''
    fill_in 'Phone number', with: ''
    fill_in 'Message', with: ''
    click_on 'Submit'
    expect(page).to have_content('The form contains 4 errors.')
    expect(page).to have_content("To can't be blank")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content('Email or phone number must be provided')
    expect(page).to have_content('Phone number or email must be provided')
    expect(ActionMailer::Base.deliveries.size).to eq(0)
  end

  scenario "from Organization #show prefills 'to' field" do
    visit organization_path(@organization.id)
    expect(page).to have_link('Email Organization')
    click_on 'Email Organization'
    expect(current_path).to eq('/contacts/new')
    expect(page).to have_select('contact[to]', selected: @organization.name)
  end

end
