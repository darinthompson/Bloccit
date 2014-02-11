class User < ActiveRecord::Base
  
  ROLES = %w[member moderator admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar
  # attr_accessible :title, :body
  has_many :posts
  has_many :comments
  before_create :set_member
  mount_uploader :avatar, AvatarUploader #add this line

  private

  def set_member
    self.role = 'member'
  end

end

