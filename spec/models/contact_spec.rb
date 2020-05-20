require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { build(:contact) }

  describe 'attributes' do
    specify { expect(contact).to respond_to(:to) }
    specify { expect(contact).to respond_to(:to_name) }
    specify { expect(contact).to respond_to(:name) }
    specify { expect(contact).to respond_to(:email) }
    specify { expect(contact).to respond_to(:phone_number) }
    specify { expect(contact).to respond_to(:message) }
  end

  describe 'validations' do
    specify { expect(contact).to validate_presence_of(:to) }
    specify { expect(contact).to validate_presence_of(:name) }
    context 'without phone number' do
      before { contact.phone_number = nil }
      specify { expect(contact).to validate_presence_of(:email).with_message('or phone number must be provided') }
    end
    context 'without email' do
      before { contact.email = nil }
      specify { expect(contact).to validate_presence_of(:phone_number).with_message('or email must be provided') }
    end
  end

end
