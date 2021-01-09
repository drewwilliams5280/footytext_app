require 'rails_helper'

RSpec.describe 'Messages' do
  xit 'can create and send a message after a webhook endpoint is hit' do
    url = 'https://27b5c9c8e60f.ngrok.io/messages'
    res = Faraday.post(url) do |req|
      req.body = {"data"=>
        {"event_type"=>"message.received",
         "id"=>"364f1ab3-b77d-4936-bc44-93310f710a84",
         "occurred_at"=>"2021-01-08T04:10:58.538+00:00",
         "payload"=>
          {"cc"=>[],
           "completed_at"=>nil,
           "cost"=>nil,
           "direction"=>"inbound",
           "encoding"=>"GSM-7",
           "errors"=>[],
           "from"=>{"carrier"=>"AT&T", "line_type"=>"Wireless", "phone_number"=>ENV['MY_PHONE_NUMBER']},
           "id"=>"a8707a4c-5f2a-4d0d-90da-9e2d4e331814",
           "media"=>[],
           "messaging_profile_id"=>"400176df-1dd4-4927-b5a6-200bea589616",
           "organization_id"=>"efff6ac3-66b1-44c8-ba2f-62e42bf8a37a",
           "parts"=>1,
           "received_at"=>"2021-01-08T04:10:58.533+00:00",
           "record_type"=>"message",
           "sent_at"=>nil,
           "tags"=>[],
           "text"=>"Drew test",
           "to"=>[{"carrier"=>"Telnyx", "line_type"=>"Wireless", "phone_number"=>ENV['TELNYX_PHONE_NUMBER'], "status"=>"webhook_delivered"}],
           "type"=>"SMS",
           "valid_until"=>nil,
           "webhook_failover_url"=>nil,
           "webhook_url"=>"https://27b5c9c8e60f.ngrok.io"},
            "record_type"=>"event"},
           "meta"=>{"attempt"=>1, "delivered_to"=>"https://27b5c9c8e60f.ngrok.io"}}.to_json
          end
    expect(Contact.count).to eq(1)
    expect(Contact.first.phone_number).to eq(ENV['MY_PHONE_NUMBER'])
    expect(ContactMessage.count).to eq(1)
    expect(ContactMessage.first.text).to eq("Drew test")
    expect(TelnyxMessage.count).to eq(1)
    expect(TelnyxMessage.first.text).to eq("Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
  end
end