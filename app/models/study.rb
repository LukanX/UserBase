class Study < ActiveRecord::Base

  require 'date'
  validates :name, presence: true
end
