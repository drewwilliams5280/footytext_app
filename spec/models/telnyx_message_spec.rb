require 'rails_helper'

RSpec.describe TelnyxMessage, type: :model do
  describe "relationships" do 
    it { should belong_to :contact }
  end

  describe "validations" do
    it {should validate_presence_of :text}
  end
end
