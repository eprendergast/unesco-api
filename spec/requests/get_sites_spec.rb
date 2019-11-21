require 'rails_helper'

RSpec.describe "get all sites route", :type => :request do 
    
    let!(:sites) {FactoryBot.create_list(:random_site, 20)}
    before {get "http://localhost:4000/sites"}

    it 'returns all sites' do
        expect(JSON.parse(response.body).length).to eq (20)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end

end
