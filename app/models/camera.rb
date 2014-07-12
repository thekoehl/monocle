class Camera < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true

  belongs_to :user
  has_attached_file :latest_image
  validates_attachment_content_type :latest_image, :content_type => /\Aimage\/.*\Z/

end
