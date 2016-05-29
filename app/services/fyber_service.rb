require 'open-uri'
require 'digest/sha1'
require 'json'

class FyberService

  BASE_URL = "#{ENV['FYBER_API_URL']}/offers.json?%s&hashkey=%s"

  DEFAULT_PARAMS = {
    appid: ENV['FYBER_APP_ID'],
    device_id: ENV['FYBER_DEVICE_ID'],
    ip: ENV['FYBER_IP'],
    pub0: 'campaign2',
    offer_types: 112,
    locale: 'de',
    timestamp: Time.now.to_i,
    page: 1
  }

  def get_offers(params)
    parameters = DEFAULT_PARAMS.merge(params.symbolize_keys)
    parameter_string = parameters.sort_by{|key, value| key}.map{|key, value| "#{key}=#{value}"}.join '&'

    uri = BASE_URL % [parameter_string, hashkey(parameter_string)]

    return validate_response open(uri)
  end

  def hashkey(parameter_string)
    Digest::SHA1.hexdigest "#{parameter_string}&#{ENV['FYBER_API_KEY']}"
  end

  def validate_response(response)
    response_body = response.read
    if response.meta["x-sponsorpay-response-signature"] === Digest::SHA1.hexdigest(response_body + ENV['FYBER_API_KEY'])
      return JSON.parse(response_body)
    else
      raise 'Invalid Response Error'
    end
  end
end
