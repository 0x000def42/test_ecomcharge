FactoryBot.define do
  factory :post do

    title { build(:post_title) }
    content { build(:post_content) }
    ip { build(:post_ip) }
    user_id { build(:user).id }

    trait :with_rates do
      transient do
        rate_count { build(:rand_post_rate_count) }
      end

      after(:create) do |post, evaluator|
        build_list :rate, rate_count, post_id: post.id
      end
    end

    initialize_with { PostRepository.new.create(attributes) }
  end

  factory :post_create_params, class: OpenStruct do
    title { build(:post_title) }
    content { build(:post_content) }
    login { build(:user_login) }
    ip { build(:post_ip) }
  end

  factory :post_ip, class: String do
    initialize_with { Faker::Internet.ip_v4_address }
  end

  factory :rand_post_rate_count, class: Numeric do
    initialize_with { (1..100).sample }
  end

  factory :post_title, class: String do
    initialize_with { Faker::Lorem.sentence }
  end

  factory :post_content, class: String do
    initialize_with { Faker::Lorem.paragraph }
  end
end