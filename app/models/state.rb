class State < ApplicationRecord
    has_many :site_states
    has_many :sites, through: :site_states
end
