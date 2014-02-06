class Study < ActiveRecord::Base

  has_many :interviews, dependent: :destroy
  has_many :participants, :through => :interviews

  accepts_nested_attributes_for :interviews

  require 'date'
  validates :name, presence: true
end
