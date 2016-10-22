#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seed
  def self.start
    UserRole.delete_all
    User.delete_all
    Role.delete_all
    generate_roles
    generate_users
  end

  def self.generate_roles
    Role.create(name: "traveler")
    Role.create(name: "host")
    Role.create(name: "admin")
    puts "Roles created for traveler, host, admin"
  end

  def self.generate_users
    inactive =  User.create(first_name: 'Inactive',
                last_name:  'Johnson',
                email_address: 'inactive@restfulstay.com',
                password: 'inactive',
                phone_number: "+15049065326",
                status: 'inactive')
    puts "inactive user created"
    inactive.roles << Role.find_by(name: 'traveler')


    traveler =  User.create(first_name: 'Traveler',
                last_name:  'Johnson',
                email_address: 'traveler@restfulstay.com',
                password: 'traveler',
                phone_number: "+15049065326",
                status: 'active')
    traveler.roles << Role.find_by(name: 'traveler')
    puts "traveler user created"

    host =      User.create(first_name: 'Host',
                last_name:  'Johnson',
                email_address: 'host@restfulstay.com',
                password: 'host',
                phone_number: "+15049065326",
                status: 'active')
    host.roles << Role.find_by(name: 'traveler')
    host.roles << Role.find_by(name: 'host')
    puts "host user created"

    admin =     User.create(first_name: 'Admin',
                last_name:  'Johnson',
                email_address: 'admin@restfulstay.com',
                phone_number: "+15049065326",
                password: 'admin',
                status: 'active')
    admin.roles << Role.find_by(name: 'traveler')
    admin.roles << Role.find_by(name: 'host')
    admin.roles << Role.find_by(name: 'admin')
    puts "admin user created"
  end
end

Seed.start
