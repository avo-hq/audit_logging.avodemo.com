require "faker"

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles { {admin: false, manager: [true, false].sample, writer: [true, false].sample} }
  end
end
