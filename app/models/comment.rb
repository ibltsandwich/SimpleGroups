# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string           default(""), not null
#

class Comment < ApplicationRecord
  validates :body, :username, presence: true

  belongs_to :post
  belongs_to :user
end
