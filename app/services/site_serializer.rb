class SiteSerializer

    def initialize(site_object)
        @site = site_object
    end

    def to_serialized_json 
        options = {
            :include => {
                :category => {:only => [:id, :name]}, 
                :region => {:only => [:id, :name]}, 
                :states => {:only => [:id, :name]},
                :iso_codes => {:only => [:id, :alpha_2_code]}
            }, :except => [:category_id, :region_id, :created_at, :updated_at]
        }

       @site.to_json(options) 
    end

end