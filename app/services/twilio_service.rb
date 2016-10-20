require 'net/http'
require 'uri'

class TwilioService

  def self.code_generator
      connection
      @code
  end

  def self.generate
    @code = rand(100000...999999).to_s
  end

  def self.connection
    url = URI("https://api.twilio.com/2010-04-01/Accounts/#{ENV['twilio_account_sid']}/Messages.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'multipart/form-data; boundary=---011000010111000001101001'
    request["authorization"] = ENV['authorization']
    request["cache-control"] = 'no-cache'
    request["postman-token"] = ENV['postman-token']
    request.body = "-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"Body\"\r\n\r\nHello from RESTfulStay, Enter your code #{TwilioService.generate} to the confirmation page in our website\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"To\"\r\n\r\n#{ENV['to_number']}\r\n-----011000010111000001101001\r\nContent-Disposition: form-data; name=\"From\"\r\n\r\n#{ENV['from_number']}\r\n-----011000010111000001101001--"

    response = http.request(request)
    response.read_body
  end
end
