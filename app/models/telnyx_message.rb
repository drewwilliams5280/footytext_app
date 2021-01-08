class TelnyxMessage < ApplicationRecord
  validates_presence_of :text, require: true

  belongs_to :contact
end
