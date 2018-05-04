FactoryBot.define do
  factory :request do
    title "MyStringTitle"
    body "MyText"
    owner_id 1
    executor_id 1
  end

  factory :invalid_request, class: "Request" do
    title nil
    body nil
    owner_id "nil"
    executor_id "nil"
  end
end
