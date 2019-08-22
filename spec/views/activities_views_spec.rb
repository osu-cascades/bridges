require 'rails_helper'

RSpec.describe 'activities/show.html.haml' do
  it 'does not displays attributes that do not exist' do
    activity = build(:activity)
    assign(:activity, activity)

    render

    expect(rendered).to have_selector('h5', text: 'Title')
    expect(rendered).to have_selector('p', text: activity.title)
    expect(rendered).to have_selector('h5', text: 'Location')
    expect(rendered).to have_selector('p', text: activity.location)
    expect(rendered).to have_selector('h5', text: 'Start Date')
    expect(rendered).to have_selector('h5', text: 'End Date')
    expect(rendered).to have_selector('h5', text: 'Description')
    expect(rendered).to have_selector('p', text: activity.description)
    expect(rendered).to have_selector('h5', text: 'Contact Name')
    expect(rendered).to have_selector('p', text: activity.contact_name)
    expect(rendered).to have_selector('h5', text: 'Contact Number')
    expect(rendered).to have_selector('p', text: activity.contact_number)
    expect(rendered).to have_selector('h5', text: 'Contact Email')
    expect(rendered).to have_selector('p', text: activity.contact_email)
    expect(rendered).to have_selector('h5', text: 'Organization')
    expect(rendered).to have_selector('p', text: activity.organization_name)
    expect(rendered).to_not have_selector('h5', text: 'Tags')
  end

  it 'displays tags' do
    activity = build(:activity, tag_list: ['tacos', 'free'])
    assign(:activity, activity)

    render

    expect(rendered).to have_selector('h5', text: 'Title')
    expect(rendered).to have_selector('p', text: activity.title)
    expect(rendered).to have_selector('h5', text: 'Location')
    expect(rendered).to have_selector('p', text: activity.location)
    expect(rendered).to have_selector('h5', text: 'Start Date')
    expect(rendered).to have_selector('h5', text: 'End Date')
    expect(rendered).to have_selector('h5', text: 'Description')
    expect(rendered).to have_selector('p', text: activity.description)
    expect(rendered).to have_selector('h5', text: 'Contact Name')
    expect(rendered).to have_selector('p', text: activity.contact_name)
    expect(rendered).to have_selector('h5', text: 'Contact Number')
    expect(rendered).to have_selector('p', text: activity.contact_number)
    expect(rendered).to have_selector('h5', text: 'Contact Email')
    expect(rendered).to have_selector('p', text: activity.contact_email)
    expect(rendered).to have_selector('h5', text: 'Organization')
    expect(rendered).to have_selector('p', text: activity.organization_name)
    expect(rendered).to have_selector('h5', text: 'Tags')
    activity.tag_list.each do |tag|
      expect(rendered).to have_selector('div > .btn.btn-secondary.btn-sm.btn-static', text: tag)
    end
  end
end

RSpec.describe 'activities/new.html.haml' do
  it 'displays form' do
    assign(:activity, Activity.new)

    render

    expect(rendered).to have_selector('label', text: 'Title')
    expect(rendered).to have_selector('input[type="text"][name="activity[title]"]')
    expect(rendered).to have_selector('label', text: 'Description')
    expect(rendered).to have_selector('textarea[name="activity[description]"]')
    expect(rendered).to have_selector('label', text: 'Location')
    expect(rendered).to have_selector('input[type="text"][name="activity[location]"]')
    expect(rendered).to have_selector('label', text: 'Contact name')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_name]"]')
    expect(rendered).to have_selector('label', text: 'Organization name')
    expect(rendered).to have_selector('input[type="text"][name="activity[organization_name]"]')
    expect(rendered).to have_selector('label', text: 'Contact number')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_number]"]')
    expect(rendered).to have_selector('label', text: 'Contact email')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_email]"]')
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_selector('.g-recaptcha')
    expect(rendered).to have_selector('label', text: 'Time')
    expect(rendered).to have_css('input[type="hidden"][name="activity[ongoing]"]', visible: false)
    expect(rendered).to have_selector('label', text: 'Start date')
    expect(rendered).to have_selector('input[type="text"][name="activity[when_start]"]')
    expect(rendered).to have_selector('label', text: 'End date')
    expect(rendered).to have_selector('input[type="text"][name="activity[when_end]"]')
    expect(rendered).to have_selector('#onetime.btn.btn-orange.active')
    expect(rendered).to have_selector('#ongoing.btn.btn-orange')
    expect(rendered).to have_selector('input[type="submit"][value="Create Activity"]')
  end
end

RSpec.describe 'activities/edit.html.haml' do
  it 'displays form with prefilled values' do
    activity = create(:activity, tag_list: ['tacos', 'free'])
    assign(:activity, activity)

    render

    expect(rendered).to have_selector('label', text: 'Title')
    expect(rendered).to have_selector('input[type="text"][name="activity[title]"]')
    expect(rendered).to have_field('activity[title]', with: activity.title)
    expect(rendered).to have_selector('label', text: 'Description')
    expect(rendered).to have_selector('textarea[name="activity[description]"]')
    expect(rendered).to have_field('activity[description]', with: activity.description)
    expect(rendered).to have_selector('label', text: 'Location')
    expect(rendered).to have_selector('input[type="text"][name="activity[location]"]')
    expect(rendered).to have_field('activity[location]', with: activity.location)
    expect(rendered).to have_selector('label', text: 'Contact name')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_name]"]')
    expect(rendered).to have_field('activity[contact_name]', with: activity.contact_name)
    expect(rendered).to have_selector('label', text: 'Organization name')
    expect(rendered).to have_selector('input[type="text"][name="activity[organization_name]"]')
    expect(rendered).to have_field('activity[organization_name]', with: activity.organization_name)
    expect(rendered).to have_selector('label', text: 'Contact number')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_number]"]')
    expect(rendered).to have_field('activity[contact_number]', with: activity.contact_number)
    expect(rendered).to have_selector('label', text: 'Contact email')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_email]"]')
    expect(rendered).to have_field('activity[contact_email]', with: activity.contact_email)
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_field('activity[tag_list]', with: activity.tag_list)
    expect(rendered).to_not have_selector('.g-recaptcha')
    expect(rendered).to have_selector('label', text: 'Time')
    expect(rendered).to have_css('input[type="hidden"][name="activity[ongoing]"][value="false"]', visible: false)
    expect(rendered).to have_selector('label', text: 'Start date')
    expect(rendered).to have_selector('input[type="text"][name="activity[when_start]"]')
    expect(rendered).to have_selector('label', text: 'End date')
    expect(rendered).to have_selector('input[type="text"][name="activity[when_end]"]')
    expect(rendered).to have_selector('#onetime.btn.btn-orange.active')
    expect(rendered).to have_selector('#ongoing.btn.btn-orange')
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_field('activity[tag_list]', with: activity.tag_list.to_s)
    expect(rendered).to_not have_selector('label', text: 'State')
    expect(rendered).to_not have_select('activity[state]')
    expect(rendered).to have_selector('input[type="submit"][value="Update Activity"]')
  end

  it 'hide start and end and set ongoing as active', :focus do
    activity = create(:activity, tag_list: ['tacos', 'free'], ongoing: true)
    assign(:activity, activity)

    render

    expect(rendered).to have_selector('label', text: 'Title')
    expect(rendered).to have_selector('input[type="text"][name="activity[title]"]')
    expect(rendered).to have_field('activity[title]', with: activity.title)
    expect(rendered).to have_selector('label', text: 'Description')
    expect(rendered).to have_selector('textarea[name="activity[description]"]')
    expect(rendered).to have_field('activity[description]', with: activity.description)
    expect(rendered).to have_selector('label', text: 'Location')
    expect(rendered).to have_selector('input[type="text"][name="activity[location]"]')
    expect(rendered).to have_field('activity[location]', with: activity.location)
    expect(rendered).to have_selector('label', text: 'Contact name')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_name]"]')
    expect(rendered).to have_field('activity[contact_name]', with: activity.contact_name)
    expect(rendered).to have_selector('label', text: 'Organization name')
    expect(rendered).to have_selector('input[type="text"][name="activity[organization_name]"]')
    expect(rendered).to have_field('activity[organization_name]', with: activity.organization_name)
    expect(rendered).to have_selector('label', text: 'Contact number')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_number]"]')
    expect(rendered).to have_field('activity[contact_number]', with: activity.contact_number)
    expect(rendered).to have_selector('label', text: 'Contact email')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_email]"]')
    expect(rendered).to have_field('activity[contact_email]', with: activity.contact_email)
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_field('activity[tag_list]', with: activity.tag_list)
    expect(rendered).to_not have_selector('.g-recaptcha')
    expect(rendered).to have_selector('label', text: 'Time')
    expect(rendered).to have_css('input[type="hidden"][name="activity[ongoing]"][value="true"]', visible: false)
    expect(rendered).to have_selector('#end.hide')
    expect(rendered).to have_selector('#start.hide')
    expect(rendered).to have_selector('#onetime.btn.btn-orange')
    expect(rendered).to have_selector('#ongoing.btn.btn-orange.active')
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_field('activity[tag_list]', with: activity.tag_list.to_s)
    expect(rendered).to_not have_selector('label', text: 'State')
    expect(rendered).to_not have_select('activity[state]')
    expect(rendered).to have_selector('input[type="submit"][value="Update Activity"]')
  end

  it 'displays state dropdown when admin' do
    allow(view).to receive(:current_user) { build(:user, :admin) }
    activity = create(:activity, tag_list: ['tacos', 'free'], state: :pending)
    assign(:activity, activity)

    render

    expect(rendered).to have_selector('label', text: 'Title')
    expect(rendered).to have_selector('input[type="text"][name="activity[title]"]')
    expect(rendered).to have_field('activity[title]', with: activity.title)
    expect(rendered).to have_selector('label', text: 'Description')
    expect(rendered).to have_selector('textarea[name="activity[description]"]')
    expect(rendered).to have_field('activity[description]', with: activity.description)
    expect(rendered).to have_selector('label', text: 'Location')
    expect(rendered).to have_selector('input[type="text"][name="activity[location]"]')
    expect(rendered).to have_field('activity[location]', with: activity.location)
    expect(rendered).to have_selector('label', text: 'Contact name')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_name]"]')
    expect(rendered).to have_field('activity[contact_name]', with: activity.contact_name)
    expect(rendered).to have_selector('label', text: 'Organization name')
    expect(rendered).to have_selector('input[type="text"][name="activity[organization_name]"]')
    expect(rendered).to have_field('activity[organization_name]', with: activity.organization_name)
    expect(rendered).to have_selector('label', text: 'Contact number')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_number]"]')
    expect(rendered).to have_field('activity[contact_number]', with: activity.contact_number)
    expect(rendered).to have_selector('label', text: 'Contact email')
    expect(rendered).to have_selector('input[type="text"][name="activity[contact_email]"]')
    expect(rendered).to have_field('activity[contact_email]', with: activity.contact_email)
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_field('activity[tag_list]', with: activity.tag_list)
    expect(rendered).to_not have_selector('.g-recaptcha')
    expect(rendered).to have_selector('label', text: 'Time')
    expect(rendered).to have_css('input[type="hidden"][name="activity[ongoing]"][value="false"]', visible: false)
    expect(rendered).to have_selector('label', text: 'Start date')
    expect(rendered).to have_selector('input[type="text"][name="activity[when_start]"]')
    expect(rendered).to have_selector('label', text: 'End date')
    expect(rendered).to have_selector('input[type="text"][name="activity[when_end]"]')
    expect(rendered).to have_selector('#onetime.btn.btn-orange.active')
    expect(rendered).to have_selector('#ongoing.btn.btn-orange')
    expect(rendered).to have_selector('label', text: 'Tags')
    expect(rendered).to have_selector('input[type="text"][name="activity[tag_list]"]')
    expect(rendered).to have_field('activity[tag_list]', with: activity.tag_list.to_s)
    expect(rendered).to have_selector('label', text: 'State')
    expect(rendered).to have_select('activity[state]', options: ['Pending', 'Active', 'Denied'], selected: 'Pending')
    expect(rendered).to have_selector('input[type="submit"][value="Update Activity"]')
  end
end
