class User < ActiveRecord::Base

  POSSIBLE_ROLES = {'Manager' => 'manager', 'Staff' => 'staff'}

  has_one :membership
  has_one :organization, through: :membership
  # has_one :invited_organization, class_name: 'Organization', foreign_key: 'invited_organization_id'
  belongs_to :invited_organization, class_name: 'Organization', foreign_key: 'invited_organization_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  scope :all_except, -> (user){ where.not(id: user) }
  scope :exclude_users, -> (users){where.not(id: users.pluck(:id))}
  scope :invited_users, -> (organization){where(invited_organization_id: organization.id)}

  def has_pending_invitation?
    if self.invited_organization_id && self.membership.nil?
      true
    else
      false
    end
  end

  def is_confirmed_member?
    if self.membership
      return true
    else
      return false
    end
  end

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
