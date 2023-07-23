class Person < ApplicationRecord
  require 'csv'

  validates :first_name, presence: true
  validates :species, presence: true
  validates :gender, presence: true
  validates :affilations, presence: true

  has_many :locations
  has_many :affilations
end