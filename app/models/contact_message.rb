require 'footy_text'
require 'csv'
class ContactMessage < ApplicationRecord
  include FootyText
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :respond

  def respond
    team = team_methods.find { |row| text.downcase.include?(row["team"]) }
    if team.nil?
      TelnyxMessage.create!(contact: contact, text: team_codes)
    else
      TelnyxMessage.create!(contact: contact, text: send(team["method"]))
    end
  end

  def team_methods
    csv_array = []
    CSV.foreach("lib/team_methods.csv", headers: true) do |row|
      csv_array << row.to_hash
    end
    csv_array
  end
end
