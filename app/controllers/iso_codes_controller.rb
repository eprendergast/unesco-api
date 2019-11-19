class IsoCodesController < ApplicationController

    def index 
        iso_codes = IsoCode.all 
        render json: iso_codes
    end

end
