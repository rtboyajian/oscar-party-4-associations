# == Schema Information
#
# Table name: credits
#
#  id         :bigint           not null, primary key
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :integer
#  movie_id   :integer
#
class Credit < ApplicationRecord
  validates(:role, presence: true)
  validates(:actor_id, presence: true)
  validates(:movie_id, presence: true)

  belongs_to(:actor, class_name: "Actor", foreign_key: "actor_id")
  belongs_to(:movie, class_name "Movie", foreign_key: "movie_id")
end
