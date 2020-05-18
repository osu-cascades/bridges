require 'rails_helper'

RSpec.describe User, type: :model do
  let(:activity) { create :activity }

  describe 'attributes' do
    specify { expect(activity).to respond_to(:url) }
  end

  describe 'validations' do
    it 'url format' do
      expect(activity).to allow_value('http://fake.com').for(:url)
      expect(activity).to allow_value('https://fake.com').for(:url)
      expect(activity).to allow_value(nil).for(:url)
      expect(activity).to_not allow_value('FAKE').for(:url)
    end
  end

  it 'has a required title' do
    assert activity.valid?
    activity.title = ''
    refute activity.valid?
  end

  it 'validates when_start before when_end' do
    assert activity.valid?
    activity.when_start = Time.now
    activity.when_end = Time.now - 1.day
    refute activity.valid?
  end

  it 'has a list of tags' do
    assert activity.has_attribute? 'tag_list'
  end

  it 'converts tags to lowercase' do
    activity.tag_list = 'fOOd, yUmmy, Bend'
    activity.save
    expect(activity.tag_list).to eq(['food', 'yummy', 'bend'])
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
