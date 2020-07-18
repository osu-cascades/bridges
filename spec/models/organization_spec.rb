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

  describe '#editable_by?' do
    let(:admin) { build(:user, :admin) }
    it 'is editable by admins' do
      expect(organization.editable_by?(admin)).to be_truthy
    end

    it 'is editable by a member' do
      member = build(:user)
      member.organization = organization
      expect(organization.editable_by?(member)).to be_truthy
    end

    it 'is not editable by a non-member' do
      non_member = build(:user)
      expect(organization.editable_by?(non_member)).to be_falsy
    end

    it 'returns false when passed nil' do
      expect(organization.editable_by?(nil)).to be_falsy
    end

  end

  describe '#to_s' do
    it 'is the organization name' do
      result = organization.name
      expect(result.to_s).to eq(result)
    end
  end

end
