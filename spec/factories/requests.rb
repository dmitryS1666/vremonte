FactoryBot.define do
  factory :request do
    title "MyStringTitle"
    body "Text text text"
    user_id 1
    executor_id 1
  end

  factory :invalid_request, class: "Request" do
    title nil
    body nil
    user_id "nil"
    executor_id "nil"
  end
end
