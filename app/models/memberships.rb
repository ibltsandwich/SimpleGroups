# == Schema Information
#
# Table name: memberships
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  group_id :integer
#

class Memberships < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
