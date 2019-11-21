require_relative './seeds_helpers.rb'
include SeedsHelpers

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

# Generate Categories
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
    new_site = Site.create(
        name: site[:site],
        category_id: Category.find_by(name: site[:category]).id, 
        region_id: Region.find_by(name: site[:region]).id, 
        criteria_txt: site[:criteria_txt],
        danger: site[:danger],
        date_inscribed: site[:date_inscribed].to_i,
        extension: site[:extension],
        http_url: site[:http_url],
        unesco_id_number: site[:id_number].to_i,
        image_url: site[:image_url],
        justification: format_justifications(site[:justification]), 
        latitude: site[:latitude].to_f,
        longitude: site[:longitude].to_f,
        location: site[:location],
        revision: site[:revision],
        secondary_dates: site[:secondary_dates],
        short_description: site[:short_description],
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

puts "#{Site.all.length} sites created"

puts "#{SiteIsoCode.all.length} Site_ISO_Codes created"

puts "#{SiteState.all.length} Site_States created"

# data = {
#     :query=>{
#         :columns=>"21", 
#         :rows=>"1121", 
#         :row=>[
#             {
#                 :category=>"Natural", # Category
#                 :criteria_txt=>"(ix)", 
#                 :danger=>nil, 
#                 :date_inscribed=>"2007", 
#                 :extension=>"1", 
#                 :http_url=>"https://whc.unesco.org/en/list/1133", 
#                 :id_number=>"1133", 
#                 :image_url=>"https://whc.unesco.org/uploads/sites/site_1133.jpg", 
#                 :iso_code=>"al,at,be,bg,hr,de,it,ro,sk,si,es,ua", #ISOCode - split by ","
#                 :justification=>nil, 
#                 :latitude=>"49.0097222222", # to decimal/float
#                 :location=>nil, 
#                 :longitude=>"22.3388888889",  # to decimal/float
#                 :region=>"Europe and North America", # Region
#                 :revision=>"0", 
#                 :secondary_dates=>"2011,2017", 
#                 :short_description=>{
#                     :p=>{
#                         :span=>[
#                             "This transboundary property stretches over 12 countries. Since the end of the last Ice Age, European Beech spread from a few isolated refuge areas in the Alps, Carpathians", ", Dinarides", ", Mediterranean and Pyrenees over a short period of a few thousand years in a process that is still ongoing. The successful expansion across a whole continent is related to the tree’s ", "adaptability and tolerance of different climatic, geographical and physical conditions. "
#                         ]
#                     }
#                 }, 
#                 :site=>" Ancient and Primeval Beech Forests of the Carpathians and Other Regions of Europe ", 
#                 :states=>" Albania,Austria,Belgium,Bulgaria,Croatia,Germany,Italy,Romania,Slovakia,Slovenia,Spain,Ukraine ", # State = split by ","
#                 :transboundary=>"1", # boolean
#                 :unique_number=>"2152"
#             }, 
#             {
#                 :category=>"Mixed", 
#                 :criteria_txt=>"(i)(iii)(iv)(vii)", 
#                 :danger=>nil, 
#                 :date_inscribed=>"1979", 
#                 :extension=>"1", 
#                 :http_url=>"https://whc.unesco.org/en/list/99", 
#                 :id_number=>"99", 
#                 :image_url=>"https://whc.unesco.org/uploads/sites/site_99.jpg", 
#                 :iso_code=>"al,mk", 
#                 :justification=>nil, 
#                 :latitude=>"40.9918333333", 
#                 :location=>"Ohrid (municipality)", 
#                 :longitude=>"20.7041666667", 
#                 :region=>"Europe and North America", 
#                 :revision=>"0", 
#                 :secondary_dates=>"2019,1980", 
#                 :short_description=>{
#                     :p=>"A superlative natural phenomenon, Lake Ohrid provides a refuge for numerous endemic species of freshwater fauna and flora dating from the Tertiary period. Situated on the shores of the lake, the town of Ohrid is one of the oldest human settlements in Europe. Built mainly between the 7th and 19th centuries, it has the oldest Slav monastery (St Pantelejmon) and more than 800 Byzantine-style icons dating from the 11th to the end of the 14th century. In the shallow waters near the shores of the lake, three sites testify to the presence of prehistoric pile dwellings, and the small Lin Peninsula is the site of the remains of an Early Christian church founded in the middle of the 6th century."
#                     }, 
#                     :site=>"Natural and Cultural Heritage of the Ohrid region", 
#                     :states=>"Albania,North Macedonia", 
#                     :transboundary=>"1", 
#                     :unique_number=>"2313"
#             }
#         ]
#     }
# }