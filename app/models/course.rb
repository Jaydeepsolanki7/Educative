class Course < ApplicationRecord
  include Searchable

  has_one_attached :image
  belongs_to :product
end
