require 'rails_helper'

RSpec.describe CodeCount, :type => :model do

  it 'bootstrap' do
    code_count = FactoryGirl.create :code_count, language: '_language_', filename: '_filename_'

    expect(code_count.language).to eq('_language_')
    expect(code_count.filename).to eq('_filename_')
  end

end
