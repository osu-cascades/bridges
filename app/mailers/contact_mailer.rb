class ContactMailer < ApplicationMailer

  default from: 'no-reply@bettertogethercentraloregon.org'

  def contact(contact)
    @contact = contact

    contact_recipient_email = Rails.env.production? ?
      Organization.where(id: @contact.fetch(:to)).pluck(:contact_email) :
      ENV['CONTACT_RECIPIENT_EMAIL']

    mail(to: contact_recipient_email, subject: 'Bridges Contact Request')
  end

end
