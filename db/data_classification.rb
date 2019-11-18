require 'xmlhasher'
require 'byebug'

UNESCO_XML_FILE_PATH = '/Users/elizabethprendergast/Development/projects/unesco-api/db/unesco.xml'

def get_xml_file(file_path)
    File.new(file_path)
end

def parse_xml_file(xml_file)
    XmlHasher.configure do |config|
        config.snakecase = true
        config.ignore_namespaces = true
        config.string_keys = false
    end
    XmlHasher.parse(xml_file)
end

def get_categories(parsed_unesco_data) 
    parsed_unesco_data[:query][:row].map{ |site| site[:category] }.uniq
end

def get_iso_codes(parsed_unesco_data) 
    parsed_unesco_data[:query][:row].map{ |site| site[:iso_code] ? site[:iso_code].split(",") : "NIL" }.flatten.uniq.filter{ |code| code != "NIL" }.sort
end

def get_regions(parsed_unesco_data)
    parsed_unesco_data[:query][:row].map{ |site| site[:region] }.uniq
end

def get_states(parsed_unesco_data)
    parsed_unesco_data[:query][:row].map{ |site| site[:states] ? site[:states].split(",") : "NIL" }.flatten.uniq.sort
end

def get_danger_categories(parsed_unesco_data)
    parsed_unesco_data[:query][:row].map{ |site| site[:danger] }.uniq 
end

def get_justifications(parsed_unesco_data)
    parsed_unesco_data[:query][:row].map{ |site| site[:justification] ? site[:justification] : "NIL" }.uniq 
end

xml_file = get_xml_file(UNESCO_XML_FILE_PATH)
parsed_unesco_data = parse_xml_file(xml_file)

categories = get_categories(parsed_unesco_data) # Natural, Mixed, Cultural
iso_codes = get_iso_codes(parsed_unesco_data) # 167 iso_codes
regions = get_regions(parsed_unesco_data) # ["Europe and North America", "Latin America and the Caribbean", "Africa", "Asia and the Pacific", "Arab States"]
states = get_states(parsed_unesco_data) # 177 states

danger_categories = get_danger_categories(parsed_unesco_data) # [nil, "Y 1992", "Y 2003", "Y 2002", "P 2002-2006", "0", "P 2003-2009", "1", "Y 2014", "P 1999-2001", "P 1992-2003", "P 1992-2004", "Y 1997", "P 1992-1997", "P 1991-1998", "Y 1994", "Y 1996 P 1984-1992", "Y 1999", "P 2007-2010", "P 1992-2005", "Y 2001", "Y 1996", "Y 2010", "Y 2009", "P 2004-2006", "Y 2011 P 1996-2007", "Y 1992-2011", "P 1999-2006", "Y 2007", "Y 1982", "Y 2012 P 1990-2005", "Y 2012", "P 1979-2003", "P 2003-2007", "P 1988-2004", "P 2000-2012", "Y 1986", "P 2001-2012", "P 2000-2006 P 1984-1988", "Y 2006", "Y 2013", "P 1996-2006", "P 1999-2004", "P 2004-2014", "P 1984-1989", "P 1995-2003", "Y 2010 P 1993-2007", "Y 2005", "Y 2000"]
justification = get_justifications(parsed_unesco_data)

byebug


puts "HELLO"

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