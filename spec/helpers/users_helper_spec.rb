require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { build(:user) }
  let(:other_user) { build(:user) }
  let(:admin_user) { build(:user, :admin) }

  describe '#editable_by_user' do
    it 'returns true when current_user is admin' do
      expect(editable_by_user?(user, admin_user)).to eq(true)
    end

    it 'returns true when current_user is user' do
      expect(editable_by_user?(user, user)).to eq(true)
    end

    it 'returns false when current_user is not admin nor user' do
      expect(editable_by_user?(user, other_user)).to eq(false)
    end
  end
end

