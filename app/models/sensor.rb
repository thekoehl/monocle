class Sensor < ActiveRecord::Base

  #################
  # Relationships #
  #################
  belongs_to :group
  has_many :data_points, dependent: :destroy
  has_many :events, dependent: :destroy
  has_one :last_data_point, class_name: 'DataPoint', order: 'logged_at DESC'


  ###############
  # Validations #
  ###############
  validates :group, presence: true
  validates :name, presence: true
  validates :units, presence: true

  include Alarmable
end