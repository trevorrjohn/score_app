class Game < ActiveRecord::Base
  attr_accessible :title, :info
  has_many :scores

  validates_presence_of :info
  validates_uniqueness_of :title
end
