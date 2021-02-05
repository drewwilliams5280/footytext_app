require 'footy_text'
class ContactMessage < ApplicationRecord
  include FootyText
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :respond

  def respond
    if arsenal?
      TelnyxMessage.create!(contact: contact, text: arsenal)
    elsif man_u?
      TelnyxMessage.create!(contact: contact, text: man_u)
    elsif man_city?
      TelnyxMessage.create!(contact: contact, text: man_city)
    elsif chelsea?
      TelnyxMessage.create!(contact: contact, text: chelsea)
    elsif liverpool?
      TelnyxMessage.create!(contact: contact, text: liverpool)
    elsif tottenham?
      TelnyxMessage.create!(contact: contact, text: tottenham)
    elsif leicester?
      TelnyxMessage.create!(contact: contact, text: leicester)
    elsif everton?
      TelnyxMessage.create!(contact: contact, text: everton)
    elsif southampton?
      TelnyxMessage.create!(contact: contact, text: southampton)
    elsif aston_villa?
      TelnyxMessage.create!(contact: contact, text: aston_villa)
    elsif west_ham?
      TelnyxMessage.create!(contact: contact, text: west_ham)
    elsif newcastle?
      TelnyxMessage.create!(contact: contact, text: newcastle)
    elsif crystal_palace?
      TelnyxMessage.create!(contact: contact, text: crystal_palace)
    elsif wolves?
      TelnyxMessage.create!(contact: contact, text: wolves)
    elsif fulham?
      TelnyxMessage.create!(contact: contact, text: fulham)
    elsif west_brom?
      TelnyxMessage.create!(contact: contact, text: west_brom)
    elsif leeds?
      TelnyxMessage.create!(contact: contact, text: leeds)
    elsif burnley?
      TelnyxMessage.create!(contact: contact, text: burnley)
    elsif sheffield?
      TelnyxMessage.create!(contact: contact, text: sheffield)
    elsif brighton?
      TelnyxMessage.create!(contact: contact, text: brighton)
    else
      TelnyxMessage.create!(contact: contact, text: team_codes)
    end
  end

  def arsenal?
    text.downcase.include?("arsenal")
  end

  def aston_villa?
    text.downcase.include?("aston villa")
  end

  def brighton?
    text.downcase.include?("brighton")
  end

  def burnley?
    text.downcase.include?("burnley")
  end

  def chelsea?
    text.downcase.include?("chelsea")
  end

  def crystal_palace?
    text.downcase.include?("crystal palace")
  end

  def everton?
    text.downcase.include?("everton")
  end

  def fulham?
    text.downcase.include?("fulham")
  end

  def leeds?
    text.downcase.include?("leeds")
  end

  def leicester?
    text.downcase.include?("leicester")
  end

  def liverpool?
    text.downcase.include?("liverpool")
  end

  def man_city?
    text.downcase.include?("man city")
  end

  def man_u?
    text.downcase.include?("man u")
  end

  def newcastle?
    text.downcase.include?("newcastle")
  end

  def sheffield?
    text.downcase.include?("sheffield")
  end

  def southampton?
    text.downcase.include?("southampton")
  end

  def tottenham?
    text.downcase.include?("tottenham")
  end

  def west_brom?
    text.downcase.include?("west brom")
  end

  def west_ham?
    text.downcase.include?("west ham")
  end

  def wolves?
    text.downcase.include?("wolves")
  end
end
