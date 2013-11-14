class CameraEvent < ActiveRecord::Base
	has_attached_file :event_recording

	belongs_to :user

	validates :event_recording, attachment_presence: true
	validates :location, presence: true
end
