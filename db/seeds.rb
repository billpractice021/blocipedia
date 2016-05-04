User.destroy_all

5.times do 
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

User.create(email: 'test@user.com', password: 'password')