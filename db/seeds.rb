User.destroy_all
Wiki.destroy_all

5.times do 
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

User.create(email: 'test@user.com', password: 'password')

users = User.all 

50.times do 
  Wiki.create(
  	title: Faker::Lorem.sentence,
    body: Faker::Lorem.sentence,
    user: users.sample
  	)
end

