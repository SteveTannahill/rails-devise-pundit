class Label < ActiveRecord::Base

  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :colour, presence: true
  validates :name, uniqueness: { scope: [:colour] }
end
