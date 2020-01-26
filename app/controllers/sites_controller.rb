class SitesController < ApplicationController

    def index
        sites = Site.all.select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
        render json: SiteSerializer.new(sites).to_serialized_json
    end

    def show
        site = Site.find_by(id: params[:id])
        render json: SiteSerializer.new(site).to_serialized_json
    end
    
    def search
        search_type = params[:query].split("=").first
        search_term = params[:query].split("=").second
        sites = Site.get_site_search_results(search_type, search_term)
        render json: SiteSerializer.new(sites).to_serialized_json
    end

end
