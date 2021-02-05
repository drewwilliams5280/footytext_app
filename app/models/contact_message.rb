require 'footy_text'
class ContactMessage < ApplicationRecord
  include FootyText
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :respond
  def respond
    if pizza? && ice_cream?
      puts "Pizza and ice cream"
    elsif pizza?
      puts "Pizza"
    elsif ice_cream?
      puts "ice cream"
    else
      puts "Please send either the word ‘pizza’ or ‘ice cream’ for a different response"
    end
  end

  # def respond
  #   if pizza? && ice_cream?
  #     TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best and I prefer gelato")
  #   elsif pizza?
  #     TelnyxMessage.create!(contact: contact, text: "Chicago pizza is the best")
  #   elsif ice_cream?
  #     TelnyxMessage.create!(contact: contact, text: "I prefer gelato")
  #   else
  #     TelnyxMessage.create!(contact: contact, text: "Please send either the word ‘pizza’ or ‘ice cream’ for a different response")
  #   end
  # end

  def pizza?
    text.downcase.include?("pizza")
  end

  def ice_cream?
    text.downcase.include?("ice cream")
  end
end
