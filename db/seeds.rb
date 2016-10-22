#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seed
  def self.start
    UserRole.delete_all
    User.delete_all
    Role.delete_all
    City.delete_all
    generate_roles
    generate_users
    generate_cities
  end

  def self.generate_cities
    cities = ["Colorado Springs", "Denver", "Boulder", "Grand Junction", "Fort Collins", "Estes Park"]
    cities.each do |city|
      City.create(name: city)
    end
    puts "Created Cities: #{cities.join(', ')}"
  end

  def self.generate_roles
    roles = ['traveler', 'host', 'admin']
    roles.each do |role|
      Role.create(name: role)
    end
    puts "Created Roles: #{roles.join(', ')}"
  end

  def self.generate_users
    users = ['inactive', 'traveler', 'host', 'admin']
    users.each do |user|
      status = "active"
      status = "inactive" if user == 'inactive'
      User.create(first_name: user.capitalize,
                  last_name:  "Johnson",
                  email_address: "#{user}@restfulstay.com",
                  password: user,
                  status: status)
    end
    puts "Created Users: #{users.join(', ')}"
    assign_roles
  end

  def self.assign_roles
    User.find_by(first_name: "Inactive").roles << Role.find_by(name: 'traveler')
    User.find_by(first_name: "Traveler").roles << Role.find_by(name: 'traveler')
    User.find_by(first_name: "Host").roles << Role.find_by(name: 'traveler')
    User.find_by(first_name: "Host").roles << Role.find_by(name: 'host')
    User.find_by(first_name: "Admin").roles << Role.find_by(name: 'traveler')
    User.find_by(first_name: "Admin").roles << Role.find_by(name: 'host')
    User.find_by(first_name: "Admin").roles << Role.find_by(name: 'admin')
  end
end

Seed.start
