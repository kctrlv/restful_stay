#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seed
  def self.start
    UserRole.delete_all
    User.delete_all
    Role.delete_all
    City.delete_all
    Day.delete_all
    Listing.delete_all
    generate_roles
    generate_users
    generate_cities
    generate_days
    generate_listings
  end

  def self.generate_days
    first_day = Date.parse('22-10-2016')
    end_date = Date.today.next_year
    days = first_day..end_date
    days.each do |day|
      Day.create(date: day)
    end
    puts "Created Days: #{first_day} through #{end_date}"
  end

  def self.generate_cities
    cities = ["Colorado Springs", "Denver", "Boulder", "Grand Junction", "Fort Collins", "Estes Park"]
    cities.each do |city|
      City.create(name: city)
    end
    puts "Created Cities: #{cities.join(', ')}"
    assign_thumbnails_to_cities
  end

  def self.assign_thumbnails_to_cities
    City.find_by(name: "Colorado Springs").update_attribute(:image_url, 'http://i.imgur.com/YGkazHV.jpg')
    City.find_by(name: "Boulder").update_attribute(:image_url,          'http://i.imgur.com/4lGwhAG.jpg')
    City.find_by(name: "Denver").update_attribute(:image_url,           'http://i.imgur.com/kSbD7es.jpg')
    City.find_by(name: "Estes Park").update_attribute(:image_url,       'http://i.imgur.com/ctJxTC2.jpg')
    City.find_by(name: "Grand Junction").update_attribute(:image_url,   'http://i.imgur.com/Z0vsyLR.jpg')
    City.find_by(name: "Fort Collins").update_attribute(:image_url,     'http://i.imgur.com/qTDIZdD.jpg')
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
    generate_additional_hosts
  end

  def self.generate_additional_hosts
    cities = ['coloradosprings', 'denver', 'boulder', 'grandjunction', 'fortcollins', 'estespark']
    cities.each do |city|
      host = User.create(first_name: "#{city}host",
                  last_name:  "Johnson",
                  email_address: "#{city}host@restfulstay.com",
                  phone_number: "+10000000000",
                  password: "#{city}host",
                  status: 'active')
      host.roles << Role.find_by(name: 'traveler')
      host.roles << Role.find_by(name: 'host')
    end
  end

  def self.generate_listings
    city_hosts = User.all[4..9]
    city_hosts.each_with_index do |city_host, index|
      2.times do
        Listing.make({name: Faker::Address.street_name,
                      description: Faker::Lorem.sentence,
                      image_url: "http://i.imgur.com/00aovFw.jpg",
                      price_per_night: Faker::Number.decimal(2),
                      city_id: index+1,
                      start_date: Day.all[rand(1..10)].id,
                      end_date: Day.all[rand(11..20)].id }, city_host.id).save
      end
    end
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
