require 'rails_helper'

RSpec.describe 'Status requests' do
    
    describe 'GET /status' do
        it 'returns a status message' do 
            get('/status')
            json = JSON.parse(response.body)
            expect(json['status']).to eql('ok')
        end
    end

end