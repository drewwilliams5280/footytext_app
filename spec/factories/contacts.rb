FactoryBot.define do
  factory :contact do
    phone_number { "MyString" }
    carrier { "AT&T" }
    line_type { "Wireless" }
  end
end
