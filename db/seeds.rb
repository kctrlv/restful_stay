# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)





class Seed
  def self.start
    generate_roles
  end

  def self.generate_roles
    Role.delete_all
    Role.create(name: "traveler")
    Role.create(name: "host")
    Role.create(name: "admin")
    puts "Roles created for traveler, host, admin"
  end
end

Seed.start
