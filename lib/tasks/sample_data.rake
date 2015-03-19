namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Administrador", 
                 email: "admin@atlanticoportugues.com",
                 password: "foobar", 
                 password_confirmation: "foobar",
                 admin: true)

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@atlanticoportugues.com"
      password = "password"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password,
                  admin: false)
    end
  end
end
