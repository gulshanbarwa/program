FactoryBot.define do
  factory :user do
    name { "John Doe" }
    contact {"1234567890"}
    email { "john.doe@example.com" }
    password { "password" }
  end
end