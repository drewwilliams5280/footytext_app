class Contact < ApplicationRecord
  validates_presence_of :phone_number, require: true

  has_many :contact_messages
  has_many :telnyx_messages
end