FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "test#{n}" }
    password 'pass'
    password_confirmation 'pass'
    email { "#{name}+#{Rails.application.class.parent_name}@raceweb.ca" }
    authority 4 # default to regular user
  end

  factory :gallery do
    sequence(:name) { |n| "test gallery #{n}" }
    gallery_on Date.today - 90
    sequence(:code) { |n| "#{Date.today.strftime('%Y%m%d')}_#{n}" }
    association :user, factory: :user

    factory :private_gallery do
      private_key '12345'
    end
  end

  factory :photo do
    sequence(:name) { |n| "learn to walk #{n}" }
    association :gallery, factory: :gallery
    caption 'sample caption'
  end

end
