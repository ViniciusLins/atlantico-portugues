FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end

  factory :page do
    title "Home"
    body  "Bem vindo ao Atlantico Portugues!"
  end
end
