class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :password, length: { in: 4..20 }
  validates :email_address, presence: true #we need to add uniqueness for the email address
  validates_format_of :email_address, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates_length_of :api_key, is: 32
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :listings, foreign_key: :host_id
  has_many :trips, foreign_key: :guest_id

  def inactive?
    status == 'inactive'
  end
  
  def suspended?
    status == 'suspended'
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
