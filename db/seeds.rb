User.create!(name: "geralt",
						 username: "daddygeralt",
						 email: "geralt@rivia.com",
						 password: "password",
						 password_confirmation: "password",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "yennifer",
						 username: "babyyenny",
						 email: "yennifer@vengerberg.com",
						 password: "password",
						 password_confirmation: "password",
						 admin: true,
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "ciri",
						 username: "cirilla",
						 email: "cirilla@cintra.com",
						 password: "password",
						 password_confirmation: "password",
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "triss",
						 username: "marigold",
						 email: "triss@maribor.com",
						 password: "password",
						 password_confirmation: "password",
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "keira metz",
						 username: "keira",
						 email: "keira@carreras.com",
						 password: "password",
						 password_confirmation: "password",
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

99.times do |n|
	User.create!(name: Faker::Name.name,
							 username: "user#{n+1}",
							 email: Faker::Internet.email,
							 password: "password",
							 password_confirmation: "password",
							 activated: true,
							 activated_at: Time.zone.now)
end

streamers = User.where("streamer = ?", true)
days = ['2019-01-07', '2019-01-08', '2019-01-09', '2019-01-10', '2019-01-11']
start_time = '12:00:00'
end_time = '18:00:00'
i = 0

while i < days.size do
	streamers.each { |s| s.streams.create!(day: days[i], start_time: start_time, end_time: end_time) if s.streamer? }
	i = i + 1
end

users = User.all 

while i < streamers.size do
	streamers.each { |s| s.follow(streamers[i]) }
	users.each { |u| u.follow(streamers[i]) }
	i = i +1
end

