class Library < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :review
  validates_presence_of :read
  validates_presence_of :user
  validates_presence_of :note
  validates_presence_of :gender
end
