require 'rails_helper'

describe "get all sites route", :type => :request do 
    
    let!(:questions) {FactoryBot.create_list(:random_site, 20)}

    before {get 'http://localhost:3000/sites'}

    it 'returns all sites' do
        expect(JSON.parse(response.body).length).to eq (20)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end

end