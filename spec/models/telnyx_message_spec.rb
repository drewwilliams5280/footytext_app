require 'rails_helper'

RSpec.describe TelnyxMessage, type: :model do
  describe "relationships" do 
    it { should belong_to :contact }
  end

  describe "validations" do
    it {should validate_presence_of :text}
  end

  describe "creation" do 
    it "can create a new contact message" do 
      expect(TelnyxMessage.count).to eq(0)
      contact = Contact.create!(phone_number: "+8175010256", carrier: "AT&T", line_type: "Wireless")
      message = TelnyxMessage.create!(contact_id: contact.id, text: "This is a test text!")
      expect(TelnyxMessage.count).to eq(1)
      expect(message.contact_id).to eq(contact.id)
      expect(message.text).to eq("This is a test text!")
    end
  end
end
