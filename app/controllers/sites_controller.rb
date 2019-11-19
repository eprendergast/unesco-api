class SitesController < ApplicationController

    def index
        sites = Site.all 
        render json: SiteSerializer.new(sites).to_serialized_json
    end

    def show
        site = Site.find_by(id: params[:id])
        render json: SiteSerializer.new(site).to_serialized_json
    end

end
