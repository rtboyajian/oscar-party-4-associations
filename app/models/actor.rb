# == Schema Information
#
# Table name: actors
#
#  id         :bigint           not null, primary key
#  bio        :text
#  dob        :date
#  first_name :string
#  image      :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Actor < ApplicationRecord
  validates(:first_name, presence: true)
  validates(:last_name, presence: true)

  has_many(:credits, class_name: "Credit", foreign_key "actor_id")
  has_many(:filmography, through: :credits, source: :movie)
end
