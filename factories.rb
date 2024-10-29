require "faker"

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles { {admin: false, manager: [true, false].sample, writer: [true, false].sample} }
  end

  factory :product do
    name { Faker::App.name }
    description { Faker::Lorem.paragraphs(number: rand(1...3)).join("\n") }
    price { rand(10000..999000) }
    category { ::Product.categories.values.sample }
    quantity { rand(0..200) }
    manufacturer { Faker::Company.name }
    is_featured { [true, false].sample }
  end
end
