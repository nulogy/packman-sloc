FactoryGirl.define do

  factory :snapshot do
    from '2015-03-12 13:34:59 -0400'
    sha '3f0012eb5b3636c20d409f2a41ad058896cd86e5'
  end

  factory :code_count do
    snapshot
    directory 'app'
    language 'Ruby'
    filename 'filename.rb'
    blanks  411
    comments 10
    lines 1924
    scale 4.2
    scaled_lines 8080.8
  end

end
