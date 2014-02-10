class Participant < ActiveRecord::Base


  has_many :interviews, dependent: :destroy
  has_many :studies, :through => :interviews

  before_save { |user| user.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
      uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :gender, presence: true

  acts_as_taggable


end
