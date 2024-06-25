require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @new_user = users(:festival_guest)
    @admin = users(:admin)
  end
  test "valid user" do
    assert @new_user.valid?
  end
  test "new user is not an admin" do
    assert_equal false, @new_user.admin?
  end

  test "admin is an admin" do
    assert_equal true, @admin.admin?
  end

  test 'invalid without email' do
    @new_user.email = nil
    refute @new_user.valid?
    assert_not_nil @new_user.errors[:email]
  end
end
