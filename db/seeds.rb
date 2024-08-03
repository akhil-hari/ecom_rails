require 'json'

# Define the path to the JSON file
products_file_path = Rails.root.join('db', 'seeds', 'products.json')
category_file_path = Rails.root.join('db', 'seeds', 'category.json')


# Read the JSON file
products_file = File.read(products_file_path)
category_file = File.read(category_file_path)

# Parse the JSON data
products = JSON.parse(products_file)
categories = JSON.parse(category_file)
categories.each do |category|
  Category.create!(
    name: category['name'],
    image_url: category['url'],
    discount: category['discount']

  )
end

# Seed the database with the parsed data
products.each do |product|
  category = Category.find_by(name: product['category'])
  Product.create!(
    title: product['name'],
    price: product['price'],
    stock: rand(5..20),
    image_urls: product['image_urls'],
    description: product['description'],
    category_id: category.id
  )
end
