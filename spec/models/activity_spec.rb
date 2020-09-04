require 'rails_helper'

RSpec.describe User, type: :model do
  let(:activity) { build(:activity) }

  describe 'attributes' do
    specify { expect(activity).to respond_to(:title) }
    specify { expect(activity).to respond_to(:when_start) }
    specify { expect(activity).to respond_to(:start_date) }
    specify { expect(activity).to respond_to(:start_time) }
    specify { expect(activity).to respond_to(:end_date) }
    specify { expect(activity).to respond_to(:end_time) }
    specify { expect(activity).to respond_to(:when_end) }
    specify { expect(activity).to respond_to(:description) }
    specify { expect(activity).to respond_to(:location) }
    specify { expect(activity).to respond_to(:contact_name) }
    specify { expect(activity).to respond_to(:contact_number) }
    specify { expect(activity).to respond_to(:contact_email) }
    specify { expect(activity).to respond_to(:state) }
    specify { expect(activity).to respond_to(:ongoing) }
    specify { expect(activity).to respond_to(:organization_name) }
    specify { expect(activity).to respond_to(:url) }
  end

  describe 'associations' do
    specify { expect(activity).to belong_to(:author).optional(true) }
  end

  describe 'validations' do
    specify { expect(activity).to validate_presence_of(:title) }
    it 'url format' do
      expect(activity).to allow_value('http://fake.com').for(:url)
      expect(activity).to allow_value('https://fake.com').for(:url)
      expect(activity).to allow_value(nil).for(:url)
      expect(activity).to_not allow_value('FAKE').for(:url)
    end
    it 'ensure end date is not before start date' do
      expect(activity).to be_valid
      activity.end_date = activity.start_date - 1.day
      expect(activity).to_not be_valid
    end
  end

  describe 'tags' do
    specify { expect(activity).to respond_to(:tag_list) }

    it 'converts tags to lowercase' do
      activity.tag_list = 'Fake1, fAke2, FAKE3'
      activity.save
      expect(activity.tag_list).to eq(['fake1', 'fake2', 'fake3'])
    end

    it 'removes unused tags' do
      @tags = ActsAsTaggableOn::Tag.all

      activity.tag_list.add('taco')
      activity.tag_list.add('burrito')
      activity.tag_list.add('banana')
      activity.tag_list.add('enchilada')
      activity.save

      assert_equal(@tags.count, 4)

      activity.tag_list.remove('banana')
      activity.save

      expect(@tags.count).to eq(3)
      refute @tags.any? {|tag| tag.name == 'banana' }
    end
  end

end
