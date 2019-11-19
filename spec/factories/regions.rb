FactoryBot.define do

    factory :random_region, class: Region do
        name {Faker::Lorem.sentence(word_count: 3)}
    end  

  end