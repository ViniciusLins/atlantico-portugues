# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
  connection = ActiveRecord::Base.connection()
  connection.execute("DELETE FROM pages")  
  connection.execute("DELETE FROM users")
      
  User.create!(name: "Administrador", 
               email: "admin@atlanticoportugues.com",
               password: "03fUqCnYENFkY", 
               password_confirmation: "03fUqCnYENFkY",
               admin: true)

  
  Page.create!(title: "Home",
              body: "<h1>Bem vindo ao Atlântico Português </h1>
                    <h2>Esta é a página inicial do Atlântico Português</h2>")
  Page.create!(title: "Informações úteis",
              body: "<h1>Informações úteis</h1>
                    <h2>Informações úteis</h2>")
  Page.create!(title: "Sobre nós",
              body: "<h1>Sobre nós</h1>
                    <h2>sobre...</h2>")
  Page.create!(title: "Entre em contato",
              body: "<h1>Entre em contato</h1>
                    <h2>...</h2>")
