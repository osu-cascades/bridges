require 'rails_helper'

RSpec.describe 'contact_mailer/contact.html.haml' do
  it 'displays the contact information' do
    contact = build(:contact)
    assign(:contact, contact.as_json.symbolize_keys)

    render

    expect(rendered).to have_content("Hello #{contact.to_name},")
    expect(rendered).to have_content('A visitor to https://hdesd-bridges.herokuapp.com/ would like more information regarding your organization/event. You can reach them at:')
    expect(rendered).to have_content('Date:')
    expect(rendered).to have_content("Name: #{contact.name}")
    expect(rendered).to have_content("Email: #{contact.email}")
    expect(rendered).to have_content("Phone number: #{contact.phone_number}")
    expect(rendered).to have_content("Message: #{contact.message}")
    expect(rendered).to have_content('Thank you for supporting families in our community!')
    expect(rendered).to have_content('Your friends at https://hdesd-bridges.herokuapp.com/')
  end

  it 'does not display missing contact information' do
    contact = build(:contact, email: nil, message: nil)
    assign(:contact, contact.as_json.symbolize_keys)

    render

    expect(rendered).to have_content("Hello #{contact.to_name},")
    expect(rendered).to have_content('A visitor to https://hdesd-bridges.herokuapp.com/ would like more information regarding your organization/event. You can reach them at:')
    expect(rendered).to have_content('Date:')
    expect(rendered).to have_content("Name: #{contact.name}")
    expect(rendered).to_not have_content("Email:")
    expect(rendered).to have_content("Phone number: #{contact.phone_number}")
    expect(rendered).to_not have_content("Message:")
    expect(rendered).to have_content('Thank you for supporting families in our community!')
    expect(rendered).to have_content('Your friends at https://hdesd-bridges.herokuapp.com/')
  end
end
