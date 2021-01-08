require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "relationships" do 
    it { should have_many :contact_messages }
    it { should have_many :telnyx_messages }
  end

  describe "validations" do
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :carrier}
    it {should validate_presence_of :line_type}
  end

  describe "creation" do 
    it "can create a new contact" do 
      expect(Contact.count).to eq(0)
      contact = Contact.create!(phone_number: "+8175330256", carrier: "AT&T", line_type: "Wireless")
      expect(Contact.count).to eq(1)
      expect(contact.phone_number).to eq("+8175330256")
      expect(contact.carrier).to eq("AT&T")
      expect(contact.line_type).to eq("Wireless")
    end
  end
end
