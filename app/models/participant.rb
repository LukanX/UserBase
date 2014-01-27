class Participant < ActiveRecord::Base

  require 'namey'
  before_create :make_fake_name
  before_save { |user| user.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
      uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :fakename, presence: true, :on => :save
  validates :gender, presence: true

  acts_as_taggable

  def make_fake_name
    @generator = Namey::Generator.new
    if self.gender == "female"
      self.fakename = @generator.female
    elsif self.gender == "male"
      self.fakename = @generator.male
    end
  end

end
