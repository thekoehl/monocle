require 'test_helper'

class CameraEventTest < ActiveSupport::TestCase
	test "belongs_to user" do
		c = CameraEvent.new(location: "test")
		c.user = User.new
	end
end
