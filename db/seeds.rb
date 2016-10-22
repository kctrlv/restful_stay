#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seed
  def self.start
    UserRole.delete_all
    User.delete_all
    Role.delete_all
    City.delete_all
    Day.delete_all
    generate_roles
    generate_users
    generate_cities
    generate_days
  end

  def self.generate_days
    first_day = Date.parse('22-10-2016')
    days = first_day..first_day.next_year
    days.each do |day|
      Day.create(date: day)
    end
    puts "Created Days: October 22, 2016 through October 22, 2017"
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
                  phone_number: "+10000000000",
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
