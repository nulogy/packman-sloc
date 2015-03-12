# == Schema Information
#
# Table name: code_counts
#
#  id           :integer          not null, primary key
#  snapshot_id  :integer          not null
#  directory    :string           not null
#  language     :string           not null
#  filename     :string           not null
#  blanks       :integer          not null
#  comments     :integer          not null
#  lines        :integer          not null
#  scale        :decimal(, )      not null
#  scaled_lines :decimal(, )      not null
#

class CodeCount < ActiveRecord::Base

  belongs_to :snapshot

  validates_numericality_of :blanks, :only_integer => true
  validates_numericality_of :comments, :only_integer => true
  validates_numericality_of :lines, :only_integer => true
  validates_numericality_of :scale
  validates_numericality_of :scaled_lines

end
