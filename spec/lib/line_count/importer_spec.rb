require 'rails_helper'

require 'line_count/importer'

RSpec.describe LineCount::Importer do

  it 'bootstrap' do
    source_csv = StringIO.new <<-CSV.strip_heredoc
      Ruby,spec/factories.rb,411,10,1924,4.2,8080.8
      Ruby,spec/unit/shipment_test.rb,485,6,1778,4.2,7467.6
    CSV

    expect { subject.import(source_csv) }.to change { CodeCount.count }.by(2)

    code_counts = CodeCount.all

    expect(code_counts[0]).to have_attributes(language: 'Ruby', filename: 'spec/factories.rb',
        blanks: 411, comments: 10, lines: 1924, scale: 4.2, scaled_lines: 8080.8)

    expect(code_counts[1]).to have_attributes(language: 'Ruby', filename: 'spec/unit/shipment_test.rb',
        blanks: 485, comments: 6, lines: 1778, scale: 4.2, scaled_lines: 7467.6)
  end

  it 'imports from CSV source in a transaction' do
    csv_source = StringIO.new <<-CSV.strip_heredoc
      Ruby,spec/factories.rb,411,10,1924,4.2,8080.8
      Ruby,spec/unit/shipment_test.rb,485,6,1778,4.2,_bad_value_
    CSV

    expect { subject.import(csv_source) }.to raise_error(ActiveRecord::RecordInvalid).
        and change { CodeCount.count }.by(0)
  end

end
