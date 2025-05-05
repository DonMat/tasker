class Task < ApplicationRecord
  belongs_to :user

  enum :priority, {
    low: "low",
    medium: "medium",
    high: "high"
  }, prefix: true, default: :low

  validates :title, presence: true
end
