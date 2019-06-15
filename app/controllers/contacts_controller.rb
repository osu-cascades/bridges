class ContactsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid? && verify_recaptcha
      ContactMailer.contact(contact_params).deliver
      redirect_to root_url, notice: 'Thank you, your message has been sent.'
    else
      flash[:recaptcha_error]
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone_number, :message)
  end

end