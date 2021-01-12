class ContactMessage < ApplicationRecord
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :respond
  def respond
    if pizza? && ice_cream?
      TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best and I prefer gelato")
    elsif pizza?
      TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best")
    elsif ice_cream?
      TelnyxMessage.create!(contact: contact, text: "I prefer gelato")
    else
      TelnyxMessage.create!(contact: contact, text: "Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
    end
  end

  def pizza?
    text.downcase.include?("pizza")
  end

  def ice_cream?
    text.downcase.include?("ice cream")
  end
end
