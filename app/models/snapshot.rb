# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  branch     :string           not null
#  from       :datetime         not null
#  sha        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Snapshot < ActiveRecord::Base

  has_many :code_counts, dependent: :delete_all

  def to_s
    "Snapshot #{id} at #{created_at} from #{branch.chomp} (#{sha.chomp})"
  end

end
