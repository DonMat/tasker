class TimeLog < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :recorded_at, presence: true
  validates :duration_in_minutes, presence: true, numericality: { greater_than: 0, only_integer: true, less_than: 1440 }
end
