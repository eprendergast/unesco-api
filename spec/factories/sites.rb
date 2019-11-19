FactoryBot.define do

    bools = [true, false]

    factory :category
    factory :region

    factory :random_site, class: Site do
        name {Faker::Lorem.sentence(word_count: 3)}
        category_id {Faker::Number.number(digits: 3)} 
        region_id {Faker::Number.number(digits: 3)} 
        criteria_txt {Faker::Lorem.sentence(word_count: 1)}
        danger {Faker::Lorem.sentence(word_count: 1)}
        date_inscribed {Faker::Number.number(digits: 4)}
        extension {Faker::Lorem.sentence(word_count: 2)}
        http_url {Faker::Internet.url}
        unesco_id_number {Faker::Number.number(digits: 3)}
        image_url {Faker::Internet.url}
        justification {Faker::Lorem.sentence(word_count: 10)} 
        latitude {Faker::Address.latitude}
        longitude {Faker::Address.longitude}
        location {Faker::Lorem.sentence(word_count: 3)}
        revision {Faker::Lorem.sentence(word_count: 2)}
        secondary_dates {Faker::Lorem.sentence(word_count: 2)}
        short_description {Faker::Lorem.sentence(word_count: 20)}
        transboundary {bools.sample} 
        unique_number {Faker::Number.number(digits: 3)}
        category
        region

    end  

  end