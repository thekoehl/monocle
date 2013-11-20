require 'test_helper'

class CameraTest < ActiveSupport::TestCase

	#################
	# Relationships #
	#################

  test "belong_to user" do
  	c = Camera.new(name: "test")
  	c.user = User.new
  end
end
