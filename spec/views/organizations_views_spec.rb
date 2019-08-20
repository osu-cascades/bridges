require 'rails_helper'

RSpec.describe 'organizations/show.html.haml' do
  it 'does not displays attributes that do not exist' do
    organization = build(:organization, contact_email: nil)
    assign(:organization, organization)

    render

    expect(rendered).to have_selector('h5', text: 'Name')
    expect(rendered).to have_selector('p', text: organization.name)
    expect(rendered).to have_selector('h5', text: 'Location')
    expect(rendered).to have_selector('p', text: organization.location)
    expect(rendered).to have_selector('h5', text: 'Ages Served')
    expect(rendered).to have_selector('p', text: organization.ages_served)
    expect(rendered).to have_selector('h5', text: 'Programs')
    expect(rendered).to have_selector('p', text: organization.programs)
    expect(rendered).to have_selector('h5', text: 'Contact Number')
    expect(rendered).to have_selector('p', text: organization.contact_number)
    expect(rendered).to have_selector('h5', text: 'Website')
    expect(rendered).to have_selector('p', text: organization.website)

    expect(rendered).to_not have_selector('h5', text: 'Contact Email')
    expect(rendered).to_not have_selector('h5', text: 'Description')
    expect(rendered).to_not have_selector('h5', text: 'Tags')
    expect(rendered).to_not have_link('Email organization')
  end

  it 'displays tags as and link to email organization' do
    organization = build(
      :organization,
      description: 'We talk about tacos and other food-related subject matter',
      tag_list: ['tacos', 'free']
    )
    assign(:organization, organization)

    render

    expect(rendered).to have_link('Email organization', href: new_contact_path, title: "Email #{organization.name}")

    expect(rendered).to have_selector('h5', text: 'Name')
    expect(rendered).to have_selector('p', text: organization.name)
    expect(rendered).to have_selector('h5', text: 'Location')
    expect(rendered).to have_selector('p', text: organization.location)
    expect(rendered).to have_selector('h5', text: 'Ages Served')
    expect(rendered).to have_selector('p', text: organization.ages_served)
    expect(rendered).to have_selector('h5', text: 'Programs')
    expect(rendered).to have_selector('p', text: organization.programs)
    expect(rendered).to have_selector('h5', text: 'Contact Number')
    expect(rendered).to have_selector('p', text: organization.contact_number)
    expect(rendered).to have_selector('h5', text: 'Contact Email')
    expect(rendered).to have_selector('p', text: organization.contact_email)
    expect(rendered).to have_selector('h5', text: 'Website')
    expect(rendered).to have_selector('p', text: organization.website)
    expect(rendered).to have_selector('h5', text: 'Description')
    expect(rendered).to have_selector('p', text: organization.description)
    expect(rendered).to have_selector('h5', text: 'Tags')
    organization.tag_list.each do |tag|
      expect(rendered).to have_selector('div > .btn.btn-secondary.btn-sm.btn-static', text: tag)
    end
  end
end

RSpec.describe 'organizations/new.html.haml' do
  it 'displays form' do
    assign(:organization, Organization.new)

    render

    expect(rendered).to have_selector('label', text: 'Name')
    expect(rendered).to have_selector('input[type="text"][name="organization[name]"]')
    expect(rendered).to have_selector('label', text: 'Description')
    expect(rendered).to have_selector('textarea[name="organization[description]"]')
    expect(rendered).to have_selector('label', text: 'Location')
    expect(rendered).to have_selector('input[type="text"][name="organization[location]"]')
    expect(rendered).to have_selector('label', text: 'Ages served')
    expect(rendered).to have_selector('input[type="text"][name="organization[ages_served]"]')
    expect(rendered).to have_selector('label', text: 'Programs')
    expect(rendered).to have_selector('input[type="text"][name="organization[programs]"]')
    expect(rendered).to have_selector('label', text: 'Contact number')
    expect(rendered).to have_selector('input[type="text"][name="organization[contact_number]"]')
    expect(rendered).to have_selector('label', text: 'Contact email')
    expect(rendered).to have_selector('input[type="text"][name="organization[contact_email]"]')
    expect(rendered).to have_selector('label', text: 'Website')
    expect(rendered).to have_selector('input[type="text"][name="organization[website]"]')
    expect(rendered).to have_selector('label', text: 'Logo')
    expect(rendered).to have_selector('input[type="file"][name="organization[logo]"]')
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="organization[tag_list]"]')
    expect(rendered).to have_selector('input[type="submit"][value="Create Organization"]')
  end
end

RSpec.describe 'organizations/edit.html.haml' do
  it 'displays form' do
    organization = build(
      :organization,
      description: 'We talk about tacos and other food-related subject matter',
      tag_list: ['tacos', 'free']
    )
    assign(:organization, organization)

    render

    expect(rendered).to have_selector('label', text: 'Name')
    expect(rendered).to have_selector('input[type="text"][name="organization[name]"]')
    expect(rendered).to have_field('organization[name]', with: organization.name)
    expect(rendered).to have_selector('label', text: 'Description')
    expect(rendered).to have_selector('textarea[name="organization[description]"]')
    expect(rendered).to have_field('organization[description]', with: organization.description)
    expect(rendered).to have_selector('label', text: 'Location')
    expect(rendered).to have_selector('input[type="text"][name="organization[location]"]')
    expect(rendered).to have_field('organization[location]', with: organization.location)
    expect(rendered).to have_selector('label', text: 'Ages served')
    expect(rendered).to have_selector('input[type="text"][name="organization[ages_served]"]')
    expect(rendered).to have_field('organization[ages_served]', with: organization.ages_served)
    expect(rendered).to have_selector('label', text: 'Programs')
    expect(rendered).to have_selector('input[type="text"][name="organization[programs]"]')
    expect(rendered).to have_field('organization[programs]', with: organization.programs)
    expect(rendered).to have_selector('label', text: 'Contact number')
    expect(rendered).to have_selector('input[type="text"][name="organization[contact_number]"]')
    expect(rendered).to have_field('organization[contact_number]', with: organization.contact_number)
    expect(rendered).to have_selector('label', text: 'Contact email')
    expect(rendered).to have_selector('input[type="text"][name="organization[contact_email]"]')
    expect(rendered).to have_field('organization[contact_email]', with: organization.contact_email)
    expect(rendered).to have_selector('label', text: 'Website')
    expect(rendered).to have_selector('input[type="text"][name="organization[website]"]')
    expect(rendered).to have_field('organization[website]', with: organization.website)
    expect(rendered).to have_selector('label', text: 'Logo')
    expect(rendered).to have_selector('input[type="file"][name="organization[logo]"]')
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="organization[tag_list]"]')
    expect(rendered).to have_field('organization[tag_list]', with: organization.tag_list.to_s)
    expect(rendered).to have_selector('input[type="submit"][value="Create Organization"]')
  end
end
