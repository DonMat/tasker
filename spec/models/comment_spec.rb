require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }

    it 'is valid with valid attributes' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it 'is invalid without a user' do
      comment = build(:comment, user: nil)
      expect(comment).not_to be_valid
    end

    it 'is invalid without a commentable' do
      comment = build(:comment, commentable: nil)
      expect(comment).not_to be_valid
    end
  end
end
