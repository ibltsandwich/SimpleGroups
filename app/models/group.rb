# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  owner_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_name :string           default(""), not null
#

class Group < ApplicationRecord
  validates :name, :owner_id, presence: true
  validates :name, uniqueness: true

  belongs_to :owner, class_name: "User"
  has_many :memberships
  has_many :members, through: :memberships, source: :user
  has_many :posts
end
