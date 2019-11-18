class SitesController < ApplicationController

    def index
        sites = Site.all 
        render json: {sites: sites}
    end

end
