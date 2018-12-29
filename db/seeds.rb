User.create!(name: "geralt",
						 username: "daddygeralt",
						 email: "geralt@rivia.com",
						 password: "password",
						 password_confirmation: "password",
						 admin: true)

User.create!(name: "yennifer",
						 username: "babyyenny",
						 email: "yennifer@vengerberg.com",
						 password: "password",
						 password_confirmation: "password",
						 admin: true)

User.create!(name: "ciri",
						 username: "cirilla",
						 email: "cirilla@cintra.com",
						 password: "password",
						 password_confirmation: "password")

User.create!(name: "triss",
						 username: "marigold",
						 email: "triss@maribor.com",
						 password: "password",
						 password_confirmation: "password")

99.times do
	User.create!(name: Faker::Name.name,
							 username: Faker::Internet.username(5..15),
							 email: Faker::Internet.email,
							 password: "password",
							 password_confirmation: "password")
end