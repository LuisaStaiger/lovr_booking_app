require "application_system_test_case"

class FestivalsTest < ApplicationSystemTestCase
  test "counting as much cards as festivals in festivals index" do
    visit root_url
    save_and_open_screenshot
    assert_selector "card", count: Festival.count
  end
end
