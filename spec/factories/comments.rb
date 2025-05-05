FactoryBot.define do
  factory :comment do
    user
    commentable { create(:task) }
    body { "MyString" }
  end
end
