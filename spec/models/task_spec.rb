require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }

  describe 'enum' do
    it { should define_enum_for(:priority).with_prefix.with_values(low: 'low', medium: 'medium', high: 'high').backed_by_column_of_type(:string) }
    it { should define_enum_for(:priority).with_prefix.backed_by_column_of_type(:string) }
  end

  describe 'default values' do
    it 'has a default priority of low' do
      task = Task.new
      expect(task.priority).to eq('low')
    end
  end

  describe 'done task' do
    let(:task) { create(:task, :finished) }

    it 'has a done_at timestamp' do
      expect(task.done_at).not_to be_nil
    end

    it 'is marked as done' do
      expect(task.done).to be true
    end

    it '#done? returns true' do
      expect(task.done?).to be true
    end
  end
end
