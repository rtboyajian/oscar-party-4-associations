# == Schema Information
#
# Table name: movies
#
#  id           :bigint           not null, primary key
#  description  :text
#  duration     :integer
#  image        :string
#  oscar_cohort :integer
#  released_on  :date
#  result       :string           default("nominated")
#  title        :string
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  director_id  :integer
#
class Movie < ApplicationRecord
  validates(:title, presence: true, uniqueness: true)
  validates(:year, presence: true)
  validates(:director_id, presence: true)

  belongs_to(:director, class_name: "Director", foreign_key: "director_id", primary_key: "id")
end
