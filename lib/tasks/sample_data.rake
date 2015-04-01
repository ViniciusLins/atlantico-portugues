namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_users
    create_pages
    create_documents
  end
end

def create_users
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

def create_pages
  Page.create!(title: "Home",
              body: "<h1>Bem vindo ao Atlântico Português </h1>
                    <h2>Esta é a página inicial do Atlântico Português</h2>")
  Page.create!(title: "Ajuda",
              body: "<h1>Ajuda</h1>
                    <h2>Ajuda</h2>")
  Page.create!(title: "Sobre Nós",
              body: "<h1>Sobre Nós</h1>
                    <h2>sobre...</h2>")
end

def create_documents
  100.times do |n|
    Document.create!(
      title: Faker::Lorem.sentence,
      author: Faker::Name.name,
      description: Faker::Lorem.paragraph(10),
      keywords: Faker::Lorem.words(6),
      published_year: Faker::Date.between(1000.years.ago, Date.today).year,
      publisher: Faker::Company.name,
      file: File.open(Dir['spec/assets/*.pdf'].sample)
    )
  end
end
