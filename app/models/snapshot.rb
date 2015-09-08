# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  from       :datetime         not null
#  sha        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Snapshot < ActiveRecord::Base

  has_many :code_counts, dependent: :delete_all

  def self.latest
    maximum('id')
  end

  def to_s
    "Snapshot #{id} at #{created_at} from #{sha.chomp}"
  end

end
