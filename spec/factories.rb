FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'password'
  end

  factory :gadget do
    sequence(:name) { |n| "gadget#{n}" }
    description 'description'
  end

  factory :image do
    source File.open(File.join(Rails.root, '/spec/fixtures/files/image.jpg'))
  end
end