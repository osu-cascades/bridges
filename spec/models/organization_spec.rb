require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { build(:organization) }

  describe 'attributes' do
    specify { expect(organization).to respond_to(:name) }
    specify { expect(organization).to respond_to(:location) }
    specify { expect(organization).to respond_to(:ages_served) }
    specify { expect(organization).to respond_to(:programs) }
    specify { expect(organization).to respond_to(:contact_number) }
    specify { expect(organization).to respond_to(:contact_email) }
    specify { expect(organization).to respond_to(:website) }
    specify { expect(organization).to respond_to(:description) }
    specify { expect(organization).to respond_to(:logo) }
    specify { expect(organization).to respond_to(:tags) }
    specify { expect(organization).to respond_to(:active?) }
  end

  describe 'validations' do
    specify { expect(organization).to validate_presence_of(:name) }
  end

  describe 'associations' do
    specify { expect(organization).to have_many(:users) }
  end

  describe '#to_s' do
    it 'is the organization name' do
      result = organization.name
      expect(result.to_s).to eq(result)
    end
  end

end
