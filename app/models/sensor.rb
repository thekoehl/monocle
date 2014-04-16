class Sensor < ActiveRecord::Base
  validates :group, presence: true
  validates :name, presence: true
  validates :units, presence: true

  belongs_to :group
  has_many :data_points, dependent: :destroy

  def last_data_point
    return 0 if self.data_points.count == 0
    self.data_points.last
  end
end