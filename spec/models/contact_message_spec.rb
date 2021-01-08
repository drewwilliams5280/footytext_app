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
      contact = Contact.create!(phone_number: ENV['MY_PHONE_NUMBER'], carrier: "AT&T", line_type: "Wireless")
      message = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
      expect(ContactMessage.count).to eq(1)
      expect(message.contact_id).to eq(contact.id)
      expect(message.text).to eq("This is a test text!")
      expect(message.received_at).to eq(DateTime.parse("2021-01-08T04:10:58.533+00:00"))
    end
  end

  describe "model methods" do 
    describe "respond after create" do
      it "responds automatically when a contact message is created" do 
        expect(TelnyxMessage.count).to eq(0)
        contact = Contact.create!(phone_number: ENV['MY_PHONE_NUMBER'], carrier: "AT&T", line_type: "Wireless")
        contact_message = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(1)
        expect(TelnyxMessage.last.text).to eq("Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
      end
    end

    describe "respond" do
      it "can create a correct Telnyx message" do 
        expect(TelnyxMessage.count).to eq(0)
        contact = Contact.create!(phone_number: ENV['MY_PHONE_NUMBER'], carrier: "AT&T", line_type: "Wireless")
        contact_message1 = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(1)
        expect(TelnyxMessage.last.text).to eq("Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
        contact_message2 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word pizza!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(2)
        expect(TelnyxMessage.last.text).to eq("Chicago pizza is the best")
        contact_message3 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word PiZzA with weird capitalization for edge cases!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(3)
        expect(TelnyxMessage.last.text).to eq("Chicago pizza is the best")
        contact_message4 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word ice cream!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(4)
        expect(TelnyxMessage.last.text).to eq("I prefer gelato")
        contact_message5 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word IcE cReAm spelled like that for edge cases!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(5)
        expect(TelnyxMessage.last.text).to eq("I prefer gelato")
        contact_message6 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word pIZZA and IcE cReAm woah!", received_at: DateTime.parse("2021-01-08T04:10:58.533+00:00"))
        expect(TelnyxMessage.count).to eq(6)
        expect(TelnyxMessage.last.text).to eq("Chicago pizza is the best and I prefer gelato")
      end
    end
  end
end
