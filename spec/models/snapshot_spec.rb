require 'rails_helper'

RSpec.describe Snapshot, :type => :model do

  it 'bootstrap' do
    snapshot = FactoryGirl.create :snapshot, branch: 'dev'

    expect(snapshot.branch).to eq('dev')
  end

end
