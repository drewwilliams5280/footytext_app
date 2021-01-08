require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  describe "relationships" do 
    it { should belong_to :contact }
  end

  describe "validations" do
    it {should validate_presence_of :text}
    it {should validate_presence_of :received_at}
  end

  describe "creation" do 
    it "can create a new contact message" do 
      expect(ContactMessage.count).to eq(0)
      contact = Contact.create!(phone_number: "+8175010256", carrier: "AT&T", line_type: "Wireless")
      message = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
      expect(ContactMessage.count).to eq(1)
      expect(message.contact_id).to eq(contact.id)
      expect(message.text).to eq("This is a test text!")
      expect(message.received_at).to eq(DateTime.parse("2021-01-08T04:10:58.533+00:00"))
    end
  end
end
