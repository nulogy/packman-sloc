class Run < ActiveRecord::Base

  has_many :code_counts, dependent: :delete_all

end
