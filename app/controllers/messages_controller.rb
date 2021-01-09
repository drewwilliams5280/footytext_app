class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    require 'pry'; binding.pry
    json = JSON.parse(request.body.read)
    contact = Contact.find_or_create_by(json['data']['payload']['from'])
    ContactMessage.create(contact: contact, 
                          text: json['data']['payload']['text'], 
                          received_at: DateTime.parse(json['data']['payload']['received_at'])
                          )
  end
end