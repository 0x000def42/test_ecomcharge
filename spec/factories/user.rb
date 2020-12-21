FactoryBot.define do
  factory :user do
    login { build(:user_login) }

    initialize_with { UserRepository.new.create(attributes) }
  end

  factory :user_login, class: String do
    initialize_with { Faker::Internet.username }
  end
end