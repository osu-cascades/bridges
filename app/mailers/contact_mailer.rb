class ContactMailer < ApplicationMailer

  # default from: 'bettertogethercentraloregon.org'
  default from: 'no-reply@test.com'
  CONTACT_RECIPIENT_EMAIL = ENV['CONTACT_RECIPIENT_EMAIL']

  def contact(contact)
    @contact = contact
    mail(to: CONTACT_RECIPIENT_EMAIL, subject: 'Bridges Contact Request')
  end

end
