require 'rails_helper'

describe 'Traveler API' do
  it 'returns 404 when not provided an api key' do
    get "/api/v1/trips"
    res = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(res[:error]).to eq("You must provide an API key")
  end

  it 'returns 404 when provided an invalid api key' do
    parameters = { api_key: 'nonexistent_key'}
    get "/api/v1/trips", params: parameters
    res = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(res[:error]).to eq("The API key is invalid")
  end

  it 'returns a list of their trips even when they dont have any trips' do
    traveler = User.find_by(first_name: "Traveler")
    parameters = { api_key: traveler.api_key }
    get "/api/v1/trips", params: parameters
    res = JSON.parse(response.body)
    expect(response).to be_success
    expect(res.count).to eq(0)
    expect(res.class).to eq(Array)
  end

  it 'returns a list of their trips' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_books_two_trips_with_denverhost

    parameters = { api_key: traveler.api_key }
    get "/api/v1/trips", params: parameters
    res = JSON.parse(response.body, symbolize_names: true)

    expect(res.count).to eq(2)
    expect(res.first[:checkin]).to eq("2016-10-31")
    expect(res.last[:checkout]).to eq("2016-11-05")
  end

  it 'cannot leave unauthorized review for a trip they have not booked' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_books_two_trips_with_denverhost

    parameters = {
      api_key: traveler.api_key,
      subject: "This was a great place!",
      body: "I had such a good time, denverhost is such a good guy. And his cat was soft."
     }
    post "/api/v1/trips/100/reviews", params: parameters
    expect(response.status).to eq(404)
    res = JSON.parse(response.body, symbolize_names: true)
    expect(res[:error]).to eq("Unauthorized: You cannot review a trip that you have not booked")
  end


  it 'can leave a review for a trip' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_books_two_trips_with_denverhost

    parameters = {
      api_key: traveler.api_key,
      subject: "This was a great place!",
      body: "I had such a good time, denverhost is such a good guy. And his cat was soft."
     }

    post "/api/v1/trips/#{traveler.trips.first.id}/reviews", params: parameters
    expect(response).to be_success
    res = JSON.parse(response.body, symbolize_names: true)
    expect(res[:body]).to eq("Your review has been posted")
  end

  it 'cannot leave a review for a trip with missing subject' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_books_two_trips_with_denverhost

    parameters = {
      api_key: traveler.api_key,
      body: "I had such a good time, denverhost is such a good guy. And his cat was soft."
     }

    post "/api/v1/trips/#{traveler.trips.first.id}/reviews", params: parameters
    expect(response.status).to eq(404)
    res = JSON.parse(response.body, symbolize_names: true)
    expect(res[:error]).to eq("Missing parameters")
  end

  it 'cannot leave a review for a trip with missing body' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_books_two_trips_with_denverhost

    parameters = {
      api_key: traveler.api_key,
      subject: "This was a great place!"
     }

    post "/api/v1/trips/#{traveler.trips.first.id}/reviews", params: parameters
    expect(response.status).to eq(404)
    res = JSON.parse(response.body, symbolize_names: true)
    expect(res[:error]).to eq("Missing parameters")
  end

  it 'returns the review that has been posted for the trip' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_leaves_review
    parameters = { api_key: traveler.api_key }
    get "/api/v1/trips/#{traveler.trips.first.id}/reviews", params: parameters
    expect(response).to be_success
    res = JSON.parse(response.body, symbolize_names: true)
    expect(res[:body]).to eq("I had such a good time, denverhost is such a good guy. And his cat was soft.")
    expect(res[:subject]).to eq("This was a great place!")
  end

  it 'returns an error message when a review has not been posted' do
    traveler = User.find_by(first_name: "Traveler")
    traveler_leaves_review
    parameters = { api_key: traveler.api_key }
    get "/api/v1/trips/#{traveler.trips.last.id}/reviews", params: parameters
    expect(response.status).to eq(404)
    res = JSON.parse(response.body, symbolize_names: true)
    expect(res[:error]).to eq("No Review for this Trip")
  end



end
