class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validates :name, presence: true
  validates :email, presence: true
  
  def feed
    Micropost.where("user_id = ?", id)
  end
end
