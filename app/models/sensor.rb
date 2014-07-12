class Sensor < ActiveRecord::Base

  #################
  # Relationships #
  #################
  belongs_to :group
  has_many :data_points, dependent: :destroy
  has_many :events, dependent: :destroy
  has_one :last_data_point, -> { order 'logged_at DESC' }, class_name: 'DataPoint'

  ###############
  # Validations #
  ###############
  validates :group, presence: true
  validates :name, presence: true
  validates :units, presence: true

  ############
  # Concerns #
  ############
  include Alarmable
  include Statistical

end
