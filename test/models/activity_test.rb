require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  def new_activity
    Activity.new(
      who: "Everyone",
      what: "Tacos",
      where: "Bend",
      when: "Tomorrow",
      how: "Contact Howard at 123-456-7890",
      details: "Come support 'Lettuce Taco Bout It' at this FUNdraiser",
      title: "Lettuce Taco Bout It FUNdraiser"
    )
  end

  test 'has list of tags' do
    a = new_activity
    assert a.has_attribute?('tag_list')
  end

  test 'converts tags to lowercase' do
    a = new_activity
    a.tag_list = "fOOd, yUmmy, Bend"
    a.save

    assert a.tag_list = "food, yummy, bend"
  end

  test 'removes unused tags' do
    @tags = ActsAsTaggableOn::Tag.all

    a = new_activity
    a.tag_list.add('taco')
    a.tag_list.add('burrito')
    a.tag_list.add('banana')
    a.tag_list.add('enchilada')
    a.save

    assert_equal(@tags.count, 4)

    a.tag_list.remove('banana')
    a.save

    assert_equal(@tags.count, 3)
    refute @tags.any? {|tag| tag.name == 'banana' }
  end
end
