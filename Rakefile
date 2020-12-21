require 'rake'
require 'hanami/rake_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

task :perf do
  sh 'rspec spec/performance_tests.rb'
end

task seed: :environment do
  warn_level = $VERBOSE
  $VERBOSE = nil
  
  user_repo = UserRepository.new

  user_id_list = (1..100).map do |i|
    user_repo.create(login: "#{Faker::Internet.username}#{i}").id
  end

  ip_list = (1..50).map do
    Faker::Internet.ip_v4_address
  end
  progress = ProgressBar.create(format: "%a %e %P% Processed: %c from %C", total: 2000)
  repo = PostRepository.new
  2000.times do
    Hanami::Model.configuration.connection.transaction do
      100.times do
        repo.create(
          user_id: user_id_list.sample, 
          ip: ip_list.sample,
          title: "Mock title",
          content: "Mock description"
        )
      end
    end
    progress.increment
  end
  $VERBOSE = warn_level
end

task seed_rates: :environment do
  warn_level = $VERBOSE
  $VERBOSE = nil
  
  value_list = (1..5).map{|i|i}

  progress = ProgressBar.create(format: "%a %e %P% Processed: %c from %C", total: 1000)
  repo = RateRepository.new
  1000.times do |i|
    Hanami::Model.configuration.connection.transaction do
      1000.times do |j|
        repo.create(
          post_id: i * 200 + j + 1000, 
          value: value_list.sample
        )
      end
    end
    progress.increment
  end
  $VERBOSE = warn_level
end