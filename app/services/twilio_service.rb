require 'net/http'

class TwilioService

  def self.code_generator
      connection
  end

  def self.generate
    rand(100000...999999).to_s
  end

  def self.connection
    uri = URI("https://api.twilio.com/2010-04-01/Accounts/#{ENV['twilio_account_sid']}/Messages.json")
    params = {Username: ENV['twilio_account_sid'],
              Password: ENV['twilio_auth_token'],
              To: ENV['to_number'] ,
              From: ENV['from_number'],
              Body: "Hello from RESTfulStay, Enter your code #{TwilioService.generate}"
              }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    puts parse(res.body) if res.is_a?(Net::HTTP)
  end

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
