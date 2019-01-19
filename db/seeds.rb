User.create!(name: "geralt",
						 username: "daddygeralt",
						 email: "geralt@rivia.com",
						 password: "password",
						 password_confirmation: "password",
						 time_zone: "Pacific Time (US & Canada)",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "yennifer",
						 username: "babyyenny",
						 email: "yennifer@vengerberg.com",
						 password: "password",
						 password_confirmation: "password",
						 time_zone: "Pacific Time (US & Canada)",
						 admin: true,
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "ciri",
						 username: "cirilla",
						 email: "cirilla@cintra.com",
						 password: "password",
						 password_confirmation: "password",
						 time_zone: "Mountain Time (US & Canada)",
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "triss",
						 username: "marigold",
						 email: "triss@maribor.com",
						 password: "password",
						 password_confirmation: "password",
						 time_zone: "Central Time (US & Canada)",
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "keira metz",
						 username: "keira",
						 email: "keira@carreras.com",
						 password: "password",
						 password_confirmation: "password",
						 time_zone: "Eastern Time (US & Canada)",
						 streamer: true,
						 activated: true,
						 activated_at: Time.zone.now)

99.times do |n|
	User.create!(name: Faker::Name.name,
							 username: "user#{n+1}",
							 email: Faker::Internet.email,
							 password: "password",
							 password_confirmation: "password",
						 	 time_zone: "Eastern Time (US & Canada)",
							 activated: true,
							 activated_at: Time.zone.now)
end

streamers = User.where("streamer = ?", true)
days = ['2019-01-07', '2019-01-08', '2019-01-09', '2019-01-10', '2019-01-11']
start_time = DateTime.new(2019,01,01,12,00,00)
end_time = DateTime.new(2019,01,01,18,00,00)
i = 0

while i < days.size do
	streamers.each { |s| s.streams.create!(stream_day: days[i], stream_start: start_time, stream_end: end_time) if s.streamer? }
	i = i + 1
end

users = User.all 

j = 0
while j < streamers.size do
	users.each { |u| u.follow(streamers[j]) unless u == streamers[j] }
	j = j + 1
end 

streamers[0].events.create!(event_title: 'Geralts Birthday Party',
													  event_description: 'BYOB and Dont Be LATE',
													  event_day: '2019-02-01',
													  event_start: DateTime.new(2019,02,01,21,00,00),
													  event_end: DateTime.new(2019,02,02,00,00,00))

streamers[3].events.create!(event_title: 'Welcoming Party',
													  event_description: 'RSVP by Wednesday!',
													  event_day: '2019-02-08',
													  event_start: DateTime.new(2019,02,8,19,00,00),
													  event_end: DateTime.new(2019,02,8,23,00,00))

streamers[1].events.create!(event_title: 'Graduation',
													  event_description: 'Im Free Im Free',
													  event_day: '2019-03-21',
													  event_start: DateTime.new(2019,03,21,22,00,00),
													  event_end: DateTime.new(2019,03,22,00,00,00))

streamers[2].events.create!(event_title: 'Geralts Birthday Celebration',
													  event_description: 'BYOB',
													  event_day: '2019-02-02',
													  event_start: DateTime.new(2019,02,02,22,00,00),
													  event_end: DateTime.new(2019,02,03,00,00,00))