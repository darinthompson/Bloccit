class User < ActiveRecord::Base
  
  u = User.find_by_email("darint07@gmail.com")
  u.update_attribute(:role, 'admin')

  ROLES = %w[member moderator admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private

  def set_member
    self.role = 'member'
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :posts
  before_create :set_member
end
