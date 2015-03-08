require 'rails_helper'

require 'line_count/importer'

RSpec.describe LineCount::Importer do

  it 'bootstrap' do
    source_csv =  StringIO.new <<-CSV.strip_heredoc
      language,filename,blank,comment,code,scale,3rd gen. equiv,"http://cloc.sourceforge.net v 1.62  T=20.61 s (238.7 files/s, 20810.1 lines/s)"
      Ruby,test/factories.rb,411,10,1924,4.2,8080.8
      Ruby,test/unit/shipment_test.rb,485,6,1778,4.2,7467.6
    CSV

    subject.import(source_csv)

    expect(CodeCount.count).to eq(2)
  end

end
