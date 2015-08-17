class User < ActiveRecord::Base
  has_many :memberships
  has_many :organizations, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  scope :are_confirmed_members, -> { joins(:memberships).where("'memberships'.'confirmed' = ?", true)}

  def self.search(query)
    where("email like ?", "%#{query}%") 
  end
end
