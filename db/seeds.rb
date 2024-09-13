# db/seeds.rb

# Create Users
user1 = User.create!(
  email: "john.doe@example.com",
  password: "password123"
)

user2 = User.create!(
  email: "jane.smith@example.com",
  password: "password456"
)

# Create Profiles
profile1 = Profile.create!(
  user: user1,
  name: "John Doe",
  username: "johndoe123",
  gluten: false,
  dairy: true,
  peanut: false,
  seafood: false,
  soy: true,
  egg: false,
  sesame: false,
  sugar: true,
  vegetarian: false,
  vegan: false
)

profile2 = Profile.create!(
  user: user2,
  name: "Jane Smith",
  username: "janesmith456",
  gluten: true,
  dairy: false,
  peanut: false,
  seafood: true,
  soy: false,
  egg: true,
  sesame: false,
  sugar: false,
  vegetarian: true,
  vegan: true
)

# Create Products
product1 = Product.create!(
  name: "Peanut Butter",
  brand: "Nutty Goodness",
  quantity: 500,
  portiion_nbr: 10,
  portion_qty: 50,
  gluten: false,
  dairy: false,
  peanut: true,
  seafood: false,
  soy: false,
  egg: false,
  sesame: false,
  sugar: true,
  vegetarian: true,
  vegan: true,
  calories: 600,
  fat: 50,
  fat_trans: 0,
  carb: 20,
  protein: 25,
  sugarqty: 10,
  barcode: "1234567890123"
)

product2 = Product.create!(
  name: "Gluten-Free Bread",
  brand: "Healthy Bakes",
  quantity: 400,
  portiion_nbr: 8,
  portion_qty: 50,
  gluten: false,
  dairy: true,
  peanut: false,
  seafood: false,
  soy: true,
  egg: false,
  sesame: false,
  sugar: false,
  vegetarian: true,
  vegan: false,
  calories: 250,
  fat: 5,
  fat_trans: 0,
  carb: 45,
  protein: 8,
  sugarqty: 3,
  barcode: "2345678901234"
)

# Create Historicals
Historical.create!(
  profile: profile1,
  product: product1,
  results: true
)

Historical.create!(
  profile: profile2,
  product: product2,
  results: false
)

