include ActionDispatch::TestProcess

FactoryGirl.define do
	factory :camera do
		name "Test Location"
		latest_snapshot { fixture_file_upload(Rails.root.join('test','fixtures','files','test.jpg'), 'image/jpg') }
		user
	end
end
