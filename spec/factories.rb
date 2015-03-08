FactoryGirl.define do

  factory :run do
    tag 'tag'
  end

  factory :code_count do
    run
    language 'Ruby'
    filename 'filename.rb'
    blanks  411
    comments 10
    lines 1924
    scale 4.2
    scaled_lines 8080.8
  end

end
