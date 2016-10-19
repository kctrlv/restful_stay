class User < ApplicationRecord
  has_secure_password
  has_many :user_roles
  has_many :roles, through: :user_roles

  def traveler?
    roles.exists?(name: 'traveler')
  end

  def host?
    roles.exists?(name: 'host')
  end

  def admin?
    roles.exists?(name: 'admin')
  end
end
