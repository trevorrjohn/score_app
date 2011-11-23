class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates_presence_of :user_id, :points, :game_id
end
