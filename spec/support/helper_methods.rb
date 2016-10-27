def login(user, password)
  visit login_path
  fill_in "Email", with: user.email_address
  fill_in "Password", with: password
  click_on "login-button"
end

def login_as_host
  user = User.find_by(first_name: "Host")
  login(user, 'host')
end

def login_as_traveler
  user = User.find_by(first_name: "Traveler")
  login(user, 'traveler')
end

def login_as_admin
  user = User.find_by(first_name: "Admin")
  login(user, 'admin')
end

def login_as_denverhost
  user = User.find_by(first_name: "denverhost")
  login(user, 'denverhost')
end


def make_listing_for_booking
  Listing.make({name: "Cool Room",
                description: "This is a cool place",
                image_url: Faker::Avatar.image,
                price_per_night: 65.50,
                city_id: City.find_by(name: "Denver").id,
                start_date: Day.all[10].id,
                end_date: Day.all[20].id },
                User.find_by(first_name: "denverhost").id).save
  return Listing.find_by(name: "Cool Room")
end

def make_past_listing
  Listing.make({name: "Pioneer",
                description: "I created this on the first day",
                image_url: Faker::Avatar.image,
                price_per_night: 100.01,
                city_id: City.find_by(name: "Fort Collins").id,
                start_date: Day.first.id,
                end_date: Day.all[10].id },
                User.find_by(first_name: "fortcollinshost").id).save
  return Listing.find_by(name: "Pioneer")
end

def book_trip_for_listing
  trip = Trip.create(listing: make_listing_for_booking,
                     guest: User.find_by(first_name: "Traveler"),
                     checkin: Date.parse("2016-11-05"),
                     checkout: Date.parse("2016-11-07"))
  return trip
end

def traveler_books_two_trips_with_denverhost
  traveler = User.find_by(first_name: "Traveler")
  denverhost = User.find_by(first_name: "denverhost")

  traveler.trips.create(
    listing: denverhost.listings.last,
    checkin: Date.parse('2016-10-31'),
    checkout: Date.parse('2016-11-03'))
  traveler.trips.create(
    listing: denverhost.listings.first,
    checkin: Date.parse('2016-11-03'),
    checkout: Date.parse('2016-11-05'))
end

def traveler_leaves_review
  traveler = User.find_by(first_name: "Traveler")
  traveler_books_two_trips_with_denverhost
  parameters = {
    api_key: traveler.api_key,
    body: "I had such a good time, denverhost is such a good guy. And his cat was soft.",
    subject: "This was a great place!"
   }
  post "/api/v1/trips/#{traveler.trips.first.id}/review", params: parameters
end

def traveler_leaves_a_review_for_denverhost
  Review.create(trip: User.find_by(first_name: "Traveler").trips.first,
                body: "This was a good place",
                subject: "Top-Notch Hosting")
end
