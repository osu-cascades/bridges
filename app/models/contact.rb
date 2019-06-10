class Contact
  include ActiveModel::Model

  attr_accessor(
    :name,
    :email,
    :phone_number,
    :message
  )

  validates_presence_of :name
  validates_presence_of :email, message: 'or phone number must be provided', if: -> { phone_number.blank? }
  validates_presence_of :phone_number, message: 'or email must be provided', if: -> { email.blank? }
  
end
