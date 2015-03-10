# == Schema Information
#
# Table name: runs
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Run < ActiveRecord::Base

  has_many :code_counts, dependent: :delete_all

end
