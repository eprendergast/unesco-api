class Site < ApplicationRecord
    belongs_to :region

    belongs_to :category

    has_many :site_states
    has_many :states, through: :site_states

    has_many :site_iso_codes
    has_many :iso_codes, through: :site_iso_codes

    def self.get_site_search_results(search_type, search_term)
        case search_type
            when "category"
                category = Category.find_by(name: search_term)
                sites = Site.get_sites_by_category(category)
                return Site.check_for_null_results(sites)
            when "region"
                region = Region.find_by(name: search_term)
                sites = Site.get_sites_by_region(region)
                return Site.check_for_null_results(sites)
            when "state"
                state = State.find_by(name: search_term)
                sites = Site.get_sites_by_state(state)
                return Site.check_for_null_results(sites)
            when "iso_code"
                iso_code = IsoCode.find_by(alpha_2_code: search_term.downcase)
                sites = Site.get_sites_by_iso_code(iso_code)
                return Site.check_for_null_results(sites)
            else 
                return "Error: search type is invalid"
        end
    end
    
    private def self.get_sites_by_category(category)
        Site.where(category_id: category.id).select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
    end

    private def self.get_sites_by_region(region)
        Site.where(region_id: region.id).select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
    end

    private def self.get_sites_by_state(state)
        Site.all.select{ |site| site.states.map{|s| s.name}.include?(state.name)}.select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
    end

    private def self.get_sites_by_iso_code(iso_code)
        Site.all.select{ |site| site.iso_codes.map{ |code| code.alpha_2_code }.include?(iso_code.alpha_2_code)}
    end

    private def self.check_for_null_results(array_of_sites)
        (array_of_sites.length > 0) ? (array_of_sites) : ("Error: no results for given search term")
    end

end
