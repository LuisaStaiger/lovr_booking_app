require "test_helper"

class FestivalLovePodTest < ActiveSupport::TestCase
  def setup
    @festival_pod_one = festival_love_pods(:festival_pod_one)
    @festival_pod_two = festival_love_pods(:festival_pod_two)
    @festival_pod_three = festival_love_pods(:festival_pod_three)
  end

  test "festival pod one valid" do
    assert @festival_pod_one.valid?
  end
end
