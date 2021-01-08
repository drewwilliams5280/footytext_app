FactoryBot.define do
  factory :contact_message do
    text { "MyString" }
    received_at { "2021-01-08 12:50:00" }
    contact { nil }
  end
end
