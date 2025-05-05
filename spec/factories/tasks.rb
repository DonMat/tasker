FactoryBot.define do
  factory :task do
    title { "MyString" }
    done { false }
    done_at { nil }
    priority { "low" }
    user
  end
  trait :finished do
    done { true }
    done_at { Time.current }
  end
end
