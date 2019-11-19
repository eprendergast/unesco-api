class SitesController < ApplicationController

    def index
        sites = Site.all 
        render json: SiteSerializer.new(sites).to_serialized_json
    end

    def show
        site = Site.find_by(id: params[:id])
        render json: SiteSerializer.new(site).to_serialized_json
    end
    
    def search
        search_type = params[:query].split("=")[0]
        search_term = params[:query].split("=")[1].tr("+"," ")

        sites = get_site_search_results(search_type, search_term)
        render json: SiteSerializer.new(sites).to_serialized_json
    end

    private def get_site_search_results(search_type, search_term)
        case search_type
        when "category"
            category = Category.find_by(name: search_term)
            return sites = Site.where(category_id: category.id)
        when "region"
            region = Region.find_by(name: search_term)
            return sites = Site.where(region_id: region.id)
        when "state"
            state = State.find_by(name: search_term)
            return sites = Site.all.select{ |site| site.states.map{|s| s.name}.include?(state.name)}
        when "iso_code"
            iso_code = IsoCode.find_by(alpha_2_code: search_term.downcase
            return sites = Site.all.select{ |site| site.iso_codes.map{ |code| code.alpha_2_code }.include?(iso_code.alpha_2_code)}
        else 
            return "Error: search type is invalid"
        end
    end

end
