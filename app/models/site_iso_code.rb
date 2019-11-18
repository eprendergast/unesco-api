class SiteIsoCode < ApplicationRecord
    belongs_to :site 
    belongs_to :iso_code
end
