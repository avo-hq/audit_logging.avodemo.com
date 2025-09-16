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

# -------------------------------- WAREHOUSES ---------------------------------- #
Warehouse.delete_all

warehouses_names = [
  "North Warehouse",
  "South Warehouse",
  "East Depot",
  "West Depot",
  "Central Hub"
]

warehouses_progress_bar = ProgressBar.create(
  progress_params(total: warehouses_names.size, title: "Creating warehouses")
)

warehouses = warehouses_names.map do |name|
  Warehouse.create!(name: name, inventory_value_cents: 0)
end

curated_products = [
  # Apple
  {name: "iPhone 15", price_usd: 799.00, manufacturer: "Apple", category: "Phones"},
  {name: "iPhone 15 Pro Max", price_usd: 1199.00, manufacturer: "Apple", category: "Phones"},
  {name: "MacBook Air 13-inch (M3)", price_usd: 1099.00, manufacturer: "Apple", category: "Computers"},
  {name: "MacBook Pro 14-inch (M3 Pro)", price_usd: 1999.00, manufacturer: "Apple", category: "Computers"},
  {name: "iPad Air (M2)", price_usd: 599.00, manufacturer: "Apple", category: "Computers"},
  {name: "iPad Pro 11-inch (M4)", price_usd: 999.00, manufacturer: "Apple", category: "Computers"},
  {name: "Apple Watch Series 10", price_usd: 399.00, manufacturer: "Apple", category: "Wearables"},
  {name: "Apple Watch Ultra 2", price_usd: 799.00, manufacturer: "Apple", category: "Wearables"},
  {name: "AirPods Pro (2nd generation)", price_usd: 249.00, manufacturer: "Apple", category: "Music players"},
  {name: "AirPods Max", price_usd: 549.00, manufacturer: "Apple", category: "Music players"},
  {name: "Apple TV 4K (128GB)", price_usd: 149.00, manufacturer: "Apple", category: "Computers"},

  # Samsung
  {name: "Samsung Galaxy S24", price_usd: 799.99, manufacturer: "Samsung", category: "Phones"},
  {name: "Samsung Galaxy S24 Ultra", price_usd: 1299.99, manufacturer: "Samsung", category: "Phones"},
  {name: "Galaxy Watch6", price_usd: 299.99, manufacturer: "Samsung", category: "Wearables"},
  {name: "Galaxy Buds2 Pro", price_usd: 229.99, manufacturer: "Samsung", category: "Music players"},

  # Google
  {name: "Google Pixel 9", price_usd: 799.00, manufacturer: "Google", category: "Phones"},
  {name: "Pixel Watch 3", price_usd: 349.99, manufacturer: "Google", category: "Wearables"},

  # Sony
  {name: "Sony WH-1000XM5", price_usd: 399.99, manufacturer: "Sony", category: "Music players"},

  # Bose
  {name: "Bose QuietComfort Ultra Headphones", price_usd: 429.00, manufacturer: "Bose", category: "Music players"},

  # Microsoft
  {name: "Surface Laptop 7", price_usd: 1299.00, manufacturer: "Microsoft", category: "Computers"},

  # Dell / HP / Lenovo
  {name: "Dell XPS 13", price_usd: 1099.00, manufacturer: "Dell", category: "Computers"},
  {name: "HP Spectre x360 14", price_usd: 1299.99, manufacturer: "HP", category: "Computers"},
  {name: "Lenovo ThinkPad X1 Carbon", price_usd: 1499.00, manufacturer: "Lenovo", category: "Computers"}
]

# Bias towards Apple by duplicating their entries, then shuffle for mix
apple_products = curated_products.select { |p| p[:manufacturer] == "Apple" }
other_products = curated_products.reject { |p| p[:manufacturer] == "Apple" }
weighted_products = (apple_products * 2) + other_products
weighted_products.shuffle!

products_progress_bar = ProgressBar.create(
  progress_params(total: weighted_products.size, title: "Creating products")
)

weighted_products.each do |data|
  Product.create!(
    name: data[:name],
    description: "#{data[:manufacturer]} #{data[:name]} in the #{data[:category]} category.",
    price_cents: ((data[:price_usd].to_f * 100).round),
    category: data[:category],
    quantity: rand(5..50),
    manufacturer: data[:manufacturer],
    user: users.sample,
    warehouse: warehouses.sample
  )
  products_progress_bar.increment
end

# Recalculate warehouse totals after product creation
warehouses.each(&:recalc_total!)
