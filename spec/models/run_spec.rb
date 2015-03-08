require 'rails_helper'

RSpec.describe Run, :type => :model do

  it 'bootstrap' do
    run = FactoryGirl.create :run, tag: '_tag_'

    expect(run.tag).to eq('_tag_')
  end

end
