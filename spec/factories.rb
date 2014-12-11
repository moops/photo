FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "test#{n}" }
    password 'pass'
    password_confirmation 'pass'
    email { "#{name}+#{Rails.application.class.parent_name}@raceweb.ca" }
  end

  factory :gallery do
    sequence(:name) { |n| "test gallery #{n}" }
    gallery_on Date.today - 90
    code Date.today.strftime('%Y%m%d')
    association :user, factory: :user
  end

  factory :photo do
    sequence(:name) { |n| "learn to walk #{n}" }
    association :gallery, factory: :gallery
    caption 'sample caption'
  end

end
