require 'rails_helper'


  RSpec.describe TimeLog, type: :model do
    describe 'associations' do
      it { should belong_to(:task) }
      it { should belong_to(:user) }
    end

    describe 'validations' do
      it { should validate_presence_of(:recorded_at) }
      it { should validate_presence_of(:duration_in_minutes) }
      it { should validate_numericality_of(:duration_in_minutes).is_greater_than(0) }
      it { should validate_numericality_of(:duration_in_minutes).only_integer }
      it { should validate_numericality_of(:duration_in_minutes).is_less_than(1440) }
    end
  end
