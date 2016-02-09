FactoryGirl.define do
  department = %w(Sales Marketing Technical)
  factory :request do
    sequence(:name)        { |n| "#{Faker::Name.name}-#{n}" }
    sequence(:email)        { |n| "#{Faker::Internet.email}" }
    sequence(:department)        { |n| "#{department[rand(3)]}" }
    sequence(:message)        { |n| "#{Faker::Lorem.paragraph}-#{n}" }
    sequence(:done)        { |n| "#{rand(2)}" }
  end
end
