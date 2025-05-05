class Task < ApplicationRecord
  belongs_to :user
  has_many :time_logs, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  enum :priority, {
    low: "low",
    medium: "medium",
    high: "high"
  }, prefix: true, default: :low

  validates :title, presence: true
end
