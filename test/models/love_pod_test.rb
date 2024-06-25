require "test_helper"

class LovePodTest < ActiveSupport::TestCase
  def setup
    @dance_sphere = love_pods(:dance_sphere)
  end

  test "valid chill zone" do
    assert @dance_sphere.valid?
  end

  test "love_pod has many festivals through festival_love_pod" do
    assert_equal 2, @dance_sphere.festivals.size
  end
end
