FactoryBot.define do
  factory :rate do

    value { build(:rate_value) }
    post_id { build(:post).id }

    initialize_with { RateRepository.new.create(attributes) }
  end

  factory :rate_value, class: Numeric do
    initialize_with { (1..5).to_a.sample }
  end
end