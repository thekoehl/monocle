class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :api_key, presence: true

  ##################
  # Action Filters #
  ##################
  before_validation :generate_and_assign_api_key, if: Proc.new {|p| p.api_key.nil? || p.api_key = ""}
  def generate_and_assign_api_key
    self.api_key = SecureRandom.uuid
  end

  ##################
  # Associations   #
  ##################
  has_many :groups
  has_many :sensors, through: :groups

end
