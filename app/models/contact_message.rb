class ContactMessage < ApplicationRecord
  validates_presence_of :text, require: true
  validates_presence_of :received_at, require: true

  belongs_to :contact
end
