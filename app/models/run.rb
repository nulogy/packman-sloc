# == Schema Information
#
# Table name: runs
#
#  id         :integer          not null, primary key
#  branch     :string           not null
#  sha        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Run < ActiveRecord::Base

  has_many :code_counts, dependent: :delete_all

  def to_s
    "Run #{id} at #{created_at} from #{branch.chomp} (#{sha.chomp})"
  end

end
