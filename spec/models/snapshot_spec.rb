require 'rails_helper'

RSpec.describe Snapshot, :type => :model do

  it 'bootstrap' do
    snapshot = FactoryGirl.create :snapshot, sha: '3f0012eb5b3636c20d409f2a41ad058896cd86e5'

    expect(snapshot.sha).to eq('3f0012eb5b3636c20d409f2a41ad058896cd86e5')
  end

end
