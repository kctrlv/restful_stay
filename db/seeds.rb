#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seed
  def self.start
    generate_roles
    generate_users
  end

  def self.generate_roles
    Role.delete_all
    Role.create(name: "traveler")
    Role.create(name: "host")
    Role.create(name: "admin")
    puts "Roles created for traveler, host, admin"
  end

  def self.generate_users
    User.delete_all
    inactive =  User.create(first_name: 'Inactive',
                last_name:  'Johnson',
                email_address: 'inactive@restfulstay.com',
                password: 'inactive',
                status: 'inactive')
    puts "inactive user created"

    traveler =  User.create(first_name: 'Traveler',
                last_name:  'Johnson',
                email_address: 'traveler@restfulstay.com',
                password: 'traveler',
                status: 'active')
    traveler.roles << Role.find_by(name: 'traveler')
    puts "traveler user created"

    host =      User.create(first_name: 'Host',
                last_name:  'Johnson',
                email_address: 'host@restfulstay.com',
                password: 'host',
                status: 'active')
    host.roles << Role.find_by(name: 'traveler')
    host.roles << Role.find_by(name: 'host')
    puts "host user created"

    admin =     User.create(first_name: 'Admin',
                last_name:  'Johnson',
                email_address: 'admin@restfulstay.com',
                password: 'admin',
                status: 'active')
    host.roles << Role.find_by(name: 'traveler')
    host.roles << Role.find_by(name: 'host')
    host.roles << Role.find_by(name: 'admin')
    puts "admin user created"
  end
end

Seed.start
