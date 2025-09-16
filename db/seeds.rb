# AVO_ADMIN_PASSWORD=secret bin/rails db:seed

def progress_params(total:, title:)
  {
    total: total,
    format: "\e[32m%t : %B %p%% %c/%C [ %a ]\e[0m",
    progress_mark: "=",
    length: 90,
    starting_at: 0,
    title: " #{title}",
    title_width: 20,
    throttle_rate: 0.01,
    remainder_mark: "."
  }
end

# ---------------------------------- USERS ---------------------------------- #
User.delete_all

famous_users = [
  {
    first_name: "David Heinemeier",
    last_name: "Hansson",
    email: "david@hey.com"
  },
  {
    first_name: "Chris",
    last_name: "Oliver",
    email: "chris@gorails.com"
  },
  {
    first_name: "Jason",
    last_name: "Charnes",
    email: "jason@jasoncharnes.com"
  },
  {
    first_name: "Jason",
    last_name: "Swett",
    email: "jason@benfranklinlabs.com"
  },
  {
    first_name: 'Yukihiro "Matz"',
    last_name: "Matsumoto",
    email: "matz@ruby.or.jp"
  },
  {
    first_name: "Joe",
    last_name: "Masilotti",
    email: "joe@masilotti.com"
  },
  {
    first_name: "Lucian",
    last_name: "Ghinda",
    email: "lucian@ghinda.com"
  },
  {
    first_name: "Mike",
    last_name: "Perham",
    email: "mperham@gmail.com"
  },
  {
    first_name: "Taylor",
    last_name: "Otwell",
    email: "taylor@laravel.com"
  },
  {
    first_name: "Adam",
    last_name: "Watham",
    email: "adam@adamwathan.me"
  },
  {
    first_name: "Jeffery",
    last_name: "Way",
    email: "jeffrey@laracasts.com"
  },
  {
    first_name: "Adrian",
    last_name: "Marin",
    email: "adrian@adrianthedev.com"
  }
]

random_users_number = 19

users_progress_bar = ProgressBar.create(
  progress_params(total: famous_users.size + random_users_number + 1, title: "Creating users")
)

users = []
random_users_number.times do |i|
  users.push FactoryBot.create(:user)
  users_progress_bar.increment
end

users.push User.create(
  first_name: "Avo",
  last_name: "Cado",
  email: "avo@cado.com",
  password: (ENV["AVO_ADMIN_PASSWORD"] || :secret),
  roles: {
    admin: true,
    manager: false,
    writer: false
  }
)
users_progress_bar.increment

famous_users.reverse_each do |user|
  users.push(FactoryBot.create(:user, **user))
  users_progress_bar.increment
end

# ---------------------------------- PRODUCTS ---------------------------------- #
Product.delete_all

# -------------------------------- INVENTORIES --------------------------------- #
Inventory.delete_all

inventories_names = [
  "North Warehouse",
  "South Warehouse",
  "East Depot",
  "West Depot",
  "Central Hub"
]

inventories_progress_bar = ProgressBar.create(
  progress_params(total: inventories_names.size, title: "Creating inventories")
)

inventories = inventories_names.map do |name|
  Inventory.create!(name: name, total_value: 0)
  inventories_progress_bar.increment
end

products_number = 50

products_progress_bar = ProgressBar.create(
  progress_params(total: products_number, title: "Creating products")
)

products_number.times do
  FactoryBot.create(:product, user: users.sample, inventory: inventories.sample)
  products_progress_bar.increment
end

# Recalculate inventory totals after product creation
inventories.each(&:recalc_total!)
