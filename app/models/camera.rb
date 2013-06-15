class Camera < ActiveRecord::Base
  ################
  # Attributesd  #
  ################
  attr_accessible :title, :latest_snapshot
  
  ################
  # Associations #
  ################

  belongs_to :user
  has_many :camera_events

  ################
  # Gems         #
  ################
  has_attached_file :latest_snapshot, :styles => { medium: "640x480" }

  ################
  # Validations  #
  ################
  validates_presence_of :latest_snapshot
  validates_presence_of :title
end
