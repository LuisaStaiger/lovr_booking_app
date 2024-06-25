require "test_helper"

class FestivalTest < ActiveSupport::TestCase
  def setup
    @summer_fest = festivals(:summer_fest)
  end

  test "valid festival" do
    assert @summer_fest.valid?
  end

  test "festival has many love_pods through festival_love_pod" do
    assert_equal 2, @summer_fest.love_pods.size
  end
end
