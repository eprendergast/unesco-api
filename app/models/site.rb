class Site < ApplicationRecord
    belongs_to :region

    belongs_to :category

    has_many :site_states
    has_many :states, through: :site_states

    has_many :site_iso_codes
    has_many :iso_codes, through: :site_iso_codes
    
    def self.get_sites_by_category(category)
        Site.where(category_id: category.id).select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
    end

    def self.get_sites_by_region(region)
        Site.where(region_id: region.id).select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
    end

    def self.get_sites_by_state(state)
        Site.all.select{ |site| site.states.map{|s| s.name}.include?(state.name)}.select{ |site| site.image_url != "https://images.unsplash.com/photo-1548686013-c85877abc345?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" }
    end

    def self.get_sites_by_iso_code(iso_code)
        Site.all.select{ |site| site.iso_codes.map{ |code| code.alpha_2_code }.include?(iso_code.alpha_2_code)}
    end

end
