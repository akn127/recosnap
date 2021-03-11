FactoryBot.define do
  factory :record do
    title       { '北海道旅行の思い出' }
    category_id { 3 }
    date        { '2020-01-01' }
    place       { '旭川動物園' }
    with        { Faker::Internet.name }
    text        { 'この日はとても天気が良かった' }
    url         { 'https://www.city.asahikawa.hokkaido.jp/asahiyamazoo/' }
    status       { 0 }

    association :user

    after(:build) do |record|
      record.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
