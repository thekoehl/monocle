class Camera < ActiveRecord::Base
	has_attached_file :latest_snapshot, styles: { medium: "300x300" }
	belongs_to :user

	validates :latest_snapshot, :attachment_presence => true
	validates :name, presence: true
end