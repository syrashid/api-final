class Restaurant < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
end
