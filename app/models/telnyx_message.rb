class TelnyxMessage < ApplicationRecord
  validates_presence_of :text, require: true
  belongs_to :contact

  after_create :send_message
  def send_message
    Telnyx.api_key = ENV['TELNYX_API_KEY']
    Telnyx::Message.create(
      from: ENV['TELNYX_PHONE_NUMBER'],
      to: contact.phone_number,
      text: text
    )
  end
end
