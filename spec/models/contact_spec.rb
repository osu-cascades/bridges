require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { build(:contact) }

  it 'has a required name' do
    assert contact.valid?
    contact.name = ''
    refute contact.valid?
  end

  it 'is valid if only email is provided' do
    assert contact.valid?
    contact.phone_number = nil
    assert contact.valid?
  end

  it 'is valid if only phone_number is provided' do
    assert contact.valid?
    contact.email = nil
    assert contact.valid?
  end

  it 'requires either phone_number or email' do
    assert contact.valid?
    contact.email = nil
    contact.phone_number = nil
    refute contact.valid?
  end

end
