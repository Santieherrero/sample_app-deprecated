namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Example User", email: "example@example.com",
			password: "wololo",
			password_confirmation: "wololo")
		99.times do |n|
			name = Faker::Name.name 
			email= "example-#{raken+1}@example.com"
			password="wololo"
			User.create( name: name, email: email,
			 password: password,
			  password_confirmation: password)
		end
	end
end