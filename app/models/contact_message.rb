class ContactMessage < ApplicationRecord
  validates_presence_of :text, require: true
  validates_presence_of :received_at, require: true

  belongs_to :contact

  def respond
    if text.downcase.include?("pizza") && text.downcase.include?("ice cream")
      TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best and I prefer gelato")
    elsif text.downcase.include?("pizza")
      TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best")
    elsif text.downcase.include?("ice cream")
      TelnyxMessage.create!(contact: contact, text: "I prefer gelato")
    else
      TelnyxMessage.create!(contact: contact, text: "Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
    end
  end
end
