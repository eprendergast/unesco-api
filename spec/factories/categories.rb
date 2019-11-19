FactoryBot.define do

    factory :random_category, class: Category do
        name {Faker::Lorem.sentence(word_count: 1)}
    end  

  end