FactoryBot.define do
  factory :time_log do
    task
    user
    recorded_at { Time.current }
    duration_in_minutes { rand(40..200) }
  end
end
