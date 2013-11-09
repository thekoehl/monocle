require 'test_helper'

class CameraTest < ActiveSupport::TestCase

	#################
	# Relationships #
	#################

  test "belong_to user" do
  	c = Camera.new(name: "test")
  	c.user = User.new
  end

  def get_valid_user
  	user = User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
    user.save!
    return user
  end
end
