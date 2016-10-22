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
