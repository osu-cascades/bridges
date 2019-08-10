class ContactsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    recipient_name = {
      to_name: Organization.where(id: contact_params[:to]).pluck(:name).first
    }

    contact_info = recipient_name.merge(contact_params.to_hash.symbolize_keys)

    @contact = Contact.new(contact_info)
    if @contact.valid? && verify_recaptcha
      ContactMailer.contact(contact_info).deliver
      redirect_to root_url, notice: 'Thank you, your message has been sent.'
    else
      flash[:recaptcha_error]
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:to, :name, :email, :phone_number, :message)
  end

end