class User < ActiveRecord::Base

  POSSIBLE_ROLES = {'Manager' => 'manager', 'Staff' => 'staff'}

  has_one :membership
  has_one :organization, through: :membership
  belongs_to :invited_organization, class_name: 'Organization', foreign_key: 'invited_organization_id'
  has_many :documents
  has_many :feeds
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def has_pending_invitation?
    return !self.invited_organization_id.nil?
  end

  def is_confirmed_member?
    return !self.membership.nil?
  end

  def manager?
    role == 'manager'
  end

  def staff?
    role == 'staff'
  end

end
