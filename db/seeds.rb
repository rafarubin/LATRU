# db/seeds.rb

# Elimina datos existentes para evitar conflictos
User.delete_all
Profile.delete_all

# Crea usuarios
user1 = User.create!(
  email: 'user1@example.com',
  password: '123456',
  password_confirmation: '123456'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: '123456',
  password_confirmation: '123456'
)

# Crea perfiles asociados con los usuarios
user1.profiles.create!(username: 'Profile1User1')
user2.profiles.create!(username: 'Profile1User2')
