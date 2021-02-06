class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    json = JSON.parse(request.body.read)
    if json['direction'] == "inbound"
      unless ContactMessage.where(:sms_id => json['sms_id']).exists?
        contact = Contact.find_or_create_by(phone_number: json['from'])
        ContactMessage.create!(
          contact: contact, 
          text: json['body'],
          sms_id: json['sms_id']
        )
      end
    end
  end
end