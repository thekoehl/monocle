include ActionDispatch::TestProcess

FactoryGirl.define do
	factory :camera_event do
		location "Test Location"
		event_recording { fixture_file_upload(Rails.root.join('test','fixtures','files','test.swf'), 'application/shockwave') }
		user
	end
end