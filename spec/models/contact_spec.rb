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
end
