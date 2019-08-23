require 'rails_helper'

RSpec.describe 'contacts/new.html.haml' do
  it 'displays form' do
    assign(:contact, Contact.new)

    render

    expect(rendered).to have_selector('label', text: 'To')
    expect(rendered).to have_select('contact[to]')
    expect(rendered).to have_selector('label', text: 'Name')
    expect(rendered).to have_selector('input[type="text"][name="contact[name]"]')
    expect(rendered).to have_selector('label', text: 'Email')
    expect(rendered).to have_selector('input[type="text"][name="contact[email]"]')
    expect(rendered).to have_selector('label', text: 'Phone number')
    expect(rendered).to have_selector('input[type="tel"][name="contact[phone_number]"]')
    expect(rendered).to have_selector('label', text: 'Message')
    expect(rendered).to have_selector('textarea[name="contact[message]"]')
    expect(rendered).to have_selector('.g-recaptcha')
  end
end
