# == Schema Information
#
# Table name: code_counts
#
#  id           :integer          not null, primary key
#  run_id       :integer          not null
#  language     :string           not null
#  filename     :string           not null
#  blanks       :integer          not null
#  comments     :integer          not null
#  lines        :integer          not null
#  scale        :decimal(, )      not null
#  scaled_lines :decimal(, )      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CodeCount < ActiveRecord::Base

  belongs_to :run

end