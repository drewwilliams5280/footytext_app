require 'rails_helper'

RSpec.describe 'Messages' do
  xit 'can create and send a message after a webhook endpoint is hit' do
    url = 'https://84edc35679aa.ngrok.io/messages'
    res = Faraday.post(url) do |req|
      req.body = {"sms_id"=>"19104294-8e7b-45e2-9a4a-afc9865f5184", "direction"=>"inbound", "from"=>ENV['MY_PHONE_NUMBER'], "to"=>ENV['TELNYX_PHONE_NUMBER'], "body"=>"Pizza"}.to_json
          end
    expect(Contact.count).to eq(1)
    expect(Contact.first.phone_number).to eq(ENV['MY_PHONE_NUMBER'])
    expect(ContactMessage.count).to eq(1)
    expect(ContactMessage.first.text).to eq("Drew test")
    expect(TelnyxMessage.count).to eq(1)
    expect(TelnyxMessage.first.text).to eq("Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
  end
end