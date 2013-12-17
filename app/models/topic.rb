# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  body       :text
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  person_id  :integer
#

class Topic < ActiveRecord::Base
  belongs_to :group
  belongs_to :person


end
