require_relative './seeds_helpers.rb'
require_relative './scraper.rb'

include SeedsHelpers
include Scraper

Category.delete_all
Region.delete_all
State.delete_all
IsoCode.delete_all
SiteIsoCode.delete_all
SiteState.delete_all
Site.delete_all

UNESCO_XML_FILE_PATH = 'app/data/unesco.xml'

xml_file = get_xml_file(UNESCO_XML_FILE_PATH)
parsed_unesco_data = parse_xml_file(xml_file)
 Generate Categories
categories = get_categories(parsed_unesco_data) # Natural, Mixed, Cultural
categories.each{ |category| Category.create(name: category.strip)}
puts "#{Category.all.length} categories created"

# Generate Regions
regions = get_regions(parsed_unesco_data) # ["Europe and North America", "Latin America and the Caribbean", "Africa", "Asia and the Pacific", "Arab States"]
regions.each{ |region| Region.create(name: region.strip)}
puts "#{Region.all.length} regions created"

# Generate States
states = get_states(parsed_unesco_data) # 177 states
states.each{ |state| State.create(name: state.strip)}
puts "#{State.all.length} states created"

# Generate ISO Codes
iso_codes = get_iso_codes(parsed_unesco_data) # 167 iso_codes
iso_codes.each{ |code| IsoCode.create(alpha_2_code: code.strip)}
puts "#{IsoCode.all.length} ISO Codes created"

parsed_unesco_data[:query][:row].each do |site|
    new_site = Site.find_by(name: site[:site].strip)
    
    if !new_site
        if site[:site].strip != "Ngorongoro Conservation Area"
            puts "creating #{site[:site].strip}"
            new_site = Site.create(
                name: site[:site].strip,
                category_id: Category.find_by(name: site[:category]).id, 
                region_id: Region.find_by(name: site[:region]).id, 
                criteria_txt: site[:criteria_txt],
                danger: site[:danger],
                date_inscribed: site[:date_inscribed].to_i,
                extension: site[:extension],
                http_url: site[:http_url],
                unesco_id_number: site[:id_number].to_i,
                image_url: get_site_image(site[:id_number].to_i),
                justification: format_justifications(site[:justification]), 
                latitude: site[:latitude].to_f,
                longitude: site[:longitude].to_f,
                location: site[:location],
                revision: site[:revision],
                secondary_dates: site[:secondary_dates],
                short_description: format_short_description(site).chomp("{:span=>\" \"}").strip,
                transboundary: (site[:transboundary] == "1" ? true : false), 
                unique_number: site[:unique_number].to_i
            )

            if site[:iso_code]
                site[:iso_code].split(",").each do |code|
                    SiteIsoCode.create(site_id: new_site.id, iso_code_id: IsoCode.find_by(alpha_2_code: code.strip).id)
                end
            end

            if site[:states]
                site[:states].split(",").each do |state|
                    SiteState.create(site_id: new_site.id, state_id: State.find_by(name: state.strip).id)
                end
            end
        end
    end

end

puts "#{Site.all.length} sites created"

puts "#{SiteIsoCode.all.length} Site_ISO_Codes created"

puts "#{SiteState.all.length} Site_States created"
