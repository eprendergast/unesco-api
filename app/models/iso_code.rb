class IsoCode < ApplicationRecord
    has_many :site_iso_codes
    has_many :sites, through: :site_iso_codes
end
