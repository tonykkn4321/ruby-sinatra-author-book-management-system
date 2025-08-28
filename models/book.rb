class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, :year, :author_id, presence: true
end
