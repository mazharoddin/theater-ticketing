FactoryBot.define do
  factory :plan do
    remote_id { "MyString" }
    name { "MyString" }
    price { "" }
    interval { 1 }
    interval_count { 1 }
    tickets_allowed { 1 }
    ticket_category { "MyString" }
    status { 1 }
    description { "MyText" }
  end
end
