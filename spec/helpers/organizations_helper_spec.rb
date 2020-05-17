require 'rails_helper'

RSpec.describe OrganizationsHelper, type: :helper do
  let(:organization) { build(:organization) }

  describe '#organization_link' do
    context 'without an organization' do
      specify { expect(organization_link(nil)).to eq('') }
    end
    context 'with an organization' do
      specify { expect(organization_link(organization)).to match(/<a/) }
    end
  end

end
