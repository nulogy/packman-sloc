require 'rails_helper'

require 'line_count/importer'

RSpec.describe LineCount::Importer do

  it 'bootstrap' do
    source_csv = StringIO.new <<-CSV.strip_heredoc
      Ruby,test/factories.rb,411,10,1924,4.2,8080.8
      Ruby,test/unit/shipment_test.rb,485,6,1778,4.2,7467.6
    CSV

    subject.import(source_csv)

    code_counts = CodeCount.all

    expect(code_counts[0]).to have_attributes(language: 'Ruby', filename: 'test/factories.rb',
        blanks: 411, comments: 10, lines: 1924, scale: 4.2, scaled_lines: 8080.8)

    expect(code_counts[1]).to have_attributes(language: 'Ruby', filename: 'test/unit/shipment_test.rb',
        blanks: 485, comments: 6, lines: 1778, scale: 4.2, scaled_lines: 7467.6)
  end

end
