require 'open-uri'
require 'digest/sha1'
require 'json'

class FyberService

  def offers(user_id, custom, page)
    parameter_string = {
      appid: ENV['FYBER_APP_ID'],
      device_id: ENV['FYBER_DEVICE_ID'],
      uid: user_id,
      ip: ENV['FYBER_IP'],
      pub0: custom,
      offer_types: 112,
      locale: 'de',
      timestamp: Time.now.to_i,
      page: page
    }.sort_by{|key, value| key}.map{|key, value| "#{key}=#{value}"}.join '&'

    hashkey = Digest::SHA1.hexdigest "#{parameter_string}&#{ENV['FYBER_API_KEY']}"

    uri = "#{ENV['FYBER_OFFER_API_URL']}?#{parameter_string}&hashkey=#{hashkey}"

    response = open(uri)
    response_body = response.read

    if response.meta["x-sponsorpay-response-signature"] === Digest::SHA1.hexdigest(response_body + ENV['FYBER_API_KEY'])
      return JSON.parse(response_body)
    else
      raise 'Invalid Response Error'
    end
  end
end
