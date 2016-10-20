class User < ApplicationRecord
  has_secure_password
  has_many :user_roles
  has_many :roles, through: :user_roles

  def inactive?
    status == 'inactive'
  end

  def activate
    update_attribute(:status, "active")
  end

  def traveler?
    roles.exists?(name: 'traveler') && status != 'inactive'
  end

  def host?
    roles.exists?(name: 'host') && status != 'inactive'
  end

  def admin?
    roles.exists?(name: 'admin') && status != 'inactive'
  end
end
