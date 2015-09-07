class User < ActiveRecord::Base

  POSSIBLE_ROLES = {'Manager' => 'manager', 'Staff' => 'staff'}

  has_many :memberships
  has_many :organizations, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  scope :all_except, -> (user){ where.not(id: user) }
  scope :exclude_members, -> (members){where.not(id: members.pluck(:id))}
  scope :are_confirmed_members, -> { joins(:memberships).where("'memberships'.'confirmed' = ?", true).distinct}

  def self.search(query)
    where("email like ?", "%#{query}%")
  end

  def manager?
    role == 'manager'
  end

  def staff?
    role == 'staff'
  end

end
