require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it 'has a required first name' do
    assert user.valid?
    user.first_name = ''
    refute user.valid?
  end

  it 'has a required last name' do
    assert user.valid?
    user.last_name = ''
    refute user.valid?
  end

  it 'has a string representation of first_name last_name' do
    expect(user.to_s).to eq('Bob Builder')
  end

  it 'has a string representation of last_name, first_name' do
    expect(user.last_name_first_name).to eq('Builder, Bob')
  end

  it 'retains the original full name during a name change' do
    original_full_name = "#{user.first_name} #{user.last_name}"
    user.first_name = "CHANGED"
    expect(original_full_name).to eq(user.name_was)
  end

  it 'has a default role of guest' do
    new_user = User.new
    expect(new_user.role).to eq('guest')
  end

  it 'is active by default' do
    new_user = User.new
    expect(new_user.active?).to eq(true)
  end

  it 'active user is active_for_authentication' do
    new_user = User.new
    new_user.active = true
    expect(new_user.active_for_authentication?).to eq(true)
  end

  it 'inactive user is not active_for_authentication' do
    new_user = User.new
    new_user.active = false
    expect(new_user.active_for_authentication?).to eq(false)
  end

  it 'responds to status with active or inactive' do
    new_user = User.new
    new_user.active = false
    expect(new_user.status).to eq('inactive')
    new_user.active = true
    expect(new_user.status).to eq('active')
  end
end