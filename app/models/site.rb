class Site < ApplicationRecord
    belongs_to :region

    belongs_to :category

    has_many :site_states
    has_many :states, through: :site_states

    has_many :site_iso_codes
    has_many :iso_codes, through: :site_iso_codes
    
end
