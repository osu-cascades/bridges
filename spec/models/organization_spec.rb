require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { build(:organization) }

  describe 'associations' do
    specify { expect(organization).to have_many(:users) }
  end

end
