require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name is required for save" do
    u = User.new
    u.save
    assert(u.errors[:name].include?("can't be blank"))
  end
  
  test "email is required for save" do
    u = User.new
    u.save
    assert(u.errors[:email].include?("can't be blank"))
  end

end
