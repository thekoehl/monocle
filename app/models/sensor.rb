class Sensor < ActiveRecord::Base
  validates :group, presence: true
  validates :name, presence: true
  validates :units, presence: true

  belongs_to :group
  has_many :data_points
end