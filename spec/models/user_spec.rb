require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'attributes' do
    specify { expect(user).to respond_to(:email) }
    specify { expect(user).to respond_to(:first_name) }
    specify { expect(user).to respond_to(:last_name) }
    specify { expect(user).to respond_to(:role) }
    specify { expect(user).to respond_to(:active) }
  end

  describe 'validations' do
    specify { expect(user).to validate_presence_of(:first_name) }
    specify { expect(user).to validate_presence_of(:last_name) }
  end

  it 'has a default role of guest' do
    new_user = User.new
    expect(new_user.role).to eq('guest')
  end

  it 'is active by default' do
    expect(User.new.active?).to eq(true)
  end

  describe 'string representations' do
    it 'has a string representation of first_name last_name' do
      result = "#{user.first_name} #{user.last_name}"
      expect(user.to_s).to eq(result)
    end
    it 'has a string representation of last_name, first_name' do
      result = "#{user.last_name}, #{user.first_name}"
      expect(user.last_name_first_name).to eq(result)
    end
  end

  context 'active user' do
    let(:active_user) { build(:user, active: true) }
    describe '#status' do
      specify { expect(active_user.status).to eq('active') }
    end
    describe '#active_for_authentication' do
      specify { expect(active_user.active_for_authentication?).to eq(true) }
    end
  end

  context 'inactive user' do
    let(:inactive_user) { build(:user, active: false) }
    describe '#status' do
      specify { expect(inactive_user.status).to eq('inactive') }
    end
    describe '#active_for_authentication' do
      specify { expect(inactive_user.active_for_authentication?).to eq(false) }
    end
  end

  describe '#name_was' do
    it 'retains the original full name during a name change' do
      user = create(:user)
      original_full_name = "#{user.first_name} #{user.last_name}"
      user.first_name = 'CHANGED'
      expect(original_full_name).to eq(user.name_was)
    end
  end

end
