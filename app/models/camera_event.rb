class CameraEvent < ActiveRecord::Base
  ##############
  # Attributes #
  ##############
  attr_accessible :video

  ################
  # Associations #
  ################
  belongs_to :camera

  ########
  # Gems #
  ########
  has_attached_file :video

  ###############
  # Validations #
  ###############
  validates_presence_of :camera
  validates_presence_of :video
end
