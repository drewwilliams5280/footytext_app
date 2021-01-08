class Contact < ApplicationRecord
  validates_presence_of :phone_number, require: true
  validates_presence_of :carrier, require: true
  validates_presence_of :line_type, require: true

  has_many :contact_messages
  has_many :telnyx_messages
end