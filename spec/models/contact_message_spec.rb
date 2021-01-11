require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  describe "relationships" do 
    it { should belong_to :contact }
  end

  describe "validations" do
    it {should validate_presence_of :text}
  end

  describe "creation" do 
    xit "can create a new contact message" do 
      expect(ContactMessage.count).to eq(0)
      contact = Contact.create!(phone_number: ENV['MY_PHONE_NUMBER'])
      message = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!")
      expect(ContactMessage.count).to eq(1)
      expect(message.contact_id).to eq(contact.id)
      expect(message.text).to eq("This is a test text!")
    end
  end

  describe "model methods" do 
    describe "respond after create" do
      xit "responds automatically when a contact message is created" do 
        expect(TelnyxMessage.count).to eq(0)
        contact = Contact.create!(phone_number: ENV['MY_PHONE_NUMBER'])
        contact_message = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!")
        expect(TelnyxMessage.count).to eq(1)
        expect(TelnyxMessage.last.text).to eq("Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
      end
    end

    describe "respond" do
      xit "can create a correct Telnyx message" do 
        expect(TelnyxMessage.count).to eq(0)
        contact = Contact.create!(phone_number: ENV['MY_PHONE_NUMBER'])
        contact_message1 = ContactMessage.create!(contact_id: contact.id, text: "This is a test text!")
        expect(TelnyxMessage.count).to eq(1)
        expect(TelnyxMessage.last.text).to eq("Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
        contact_message2 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word pizza!")
        expect(TelnyxMessage.count).to eq(2)
        expect(TelnyxMessage.last.text).to eq("Chicago pizza is the best")
        contact_message3 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word PiZzA with weird capitalization for edge cases!")
        expect(TelnyxMessage.count).to eq(3)
        expect(TelnyxMessage.last.text).to eq("Chicago pizza is the best")
        contact_message4 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word ice cream!")
        expect(TelnyxMessage.count).to eq(4)
        expect(TelnyxMessage.last.text).to eq("I prefer gelato")
        contact_message5 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word IcE cReAm spelled like that for edge cases!")
        expect(TelnyxMessage.count).to eq(5)
        expect(TelnyxMessage.last.text).to eq("I prefer gelato")
        contact_message6 = ContactMessage.create!(contact_id: contact.id, text: "This text has the word pIZZA and IcE cReAm woah!")
        expect(TelnyxMessage.count).to eq(6)
        expect(TelnyxMessage.last.text).to eq("Chicago pizza is the best and I prefer gelato")
      end
    end
  end
end
