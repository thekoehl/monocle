class Sensor < ActiveRecord::Base
  validates :group, presence: true
  validates :name, presence: true
  validates :units, presence: true

  belongs_to :group
  has_many :data_points, dependent: :destroy
  has_one :last_data_point, class_name: 'DataPoint', order: 'logged_at DESC'
end