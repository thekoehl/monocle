class Sensor < ActiveRecord::Base
  belongs_to :user
  has_many :data_points, dependent: :destroy

  validates :name, presence: true
  validates :units, presence: true

end
