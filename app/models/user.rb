class User < ApplicationRecord
  has_secure_password
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :listings, foreign_key: :host_id

  def inactive?
    status == 'inactive'
  end

  def activate
    update_attribute(:status, "active")
  end

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
