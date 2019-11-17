require 'xmlhasher'

XmlHasher.configure do |config|
    config.snakecase = true
    config.ignore_namespaces = true
    config.string_keys = false
end

XML_file = File.new('/Users/elizabethprendergast/Development/projects/unesco/unesco-backend/db/test.xml')

parsed = XmlHasher.parse(XML_file)

data = {
    :query=>{
        :columns=>"21", 
        :rows=>"1121", 
        :row=>[
            {
                :category=>"Natural", # Category
                :criteria_txt=>"(ix)", 
                :danger=>nil, 
                :date_inscribed=>"2007", 
                :extension=>"1", 
                :http_url=>"https://whc.unesco.org/en/list/1133", 
                :id_number=>"1133", 
                :image_url=>"https://whc.unesco.org/uploads/sites/site_1133.jpg", 
                :iso_code=>"al,at,be,bg,hr,de,it,ro,sk,si,es,ua", #ISOCode - split by ","
                :justification=>nil, 
                :latitude=>"49.0097222222", # to decimal/float
                :location=>nil, 
                :longitude=>"22.3388888889",  # to decimal/float
                :region=>"Europe and North America", # Region
                :revision=>"0", 
                :secondary_dates=>"2011,2017", 
                :short_description=>{
                    :p=>{
                        :span=>[
                            "This transboundary property stretches over 12 countries. Since the end of the last Ice Age, European Beech spread from a few isolated refuge areas in the Alps, Carpathians", ", Dinarides", ", Mediterranean and Pyrenees over a short period of a few thousand years in a process that is still ongoing. The successful expansion across a whole continent is related to the tree’s ", "adaptability and tolerance of different climatic, geographical and physical conditions. "
                        ]
                    }
                }, 
                :site=>" Ancient and Primeval Beech Forests of the Carpathians and Other Regions of Europe ", 
                :states=>" Albania,Austria,Belgium,Bulgaria,Croatia,Germany,Italy,Romania,Slovakia,Slovenia,Spain,Ukraine ", # State = split by ","
                :transboundary=>"1", # boolean
                :unique_number=>"2152"
            }, 
            {
                :category=>"Mixed", 
                :criteria_txt=>"(i)(iii)(iv)(vii)", 
                :danger=>nil, 
                :date_inscribed=>"1979", 
                :extension=>"1", 
                :http_url=>"https://whc.unesco.org/en/list/99", 
                :id_number=>"99", 
                :image_url=>"https://whc.unesco.org/uploads/sites/site_99.jpg", 
                :iso_code=>"al,mk", 
                :justification=>nil, 
                :latitude=>"40.9918333333", 
                :location=>"Ohrid (municipality)", 
                :longitude=>"20.7041666667", 
                :region=>"Europe and North America", 
                :revision=>"0", 
                :secondary_dates=>"2019,1980", 
                :short_description=>{
                    :p=>"A superlative natural phenomenon, Lake Ohrid provides a refuge for numerous endemic species of freshwater fauna and flora dating from the Tertiary period. Situated on the shores of the lake, the town of Ohrid is one of the oldest human settlements in Europe. Built mainly between the 7th and 19th centuries, it has the oldest Slav monastery (St Pantelejmon) and more than 800 Byzantine-style icons dating from the 11th to the end of the 14th century. In the shallow waters near the shores of the lake, three sites testify to the presence of prehistoric pile dwellings, and the small Lin Peninsula is the site of the remains of an Early Christian church founded in the middle of the 6th century."
                    }, 
                    :site=>"Natural and Cultural Heritage of the Ohrid region", 
                    :states=>"Albania,North Macedonia", 
                    :transboundary=>"1", 
                    :unique_number=>"2313"
            }
        ]
    }
}

puts data[:query][:row].first