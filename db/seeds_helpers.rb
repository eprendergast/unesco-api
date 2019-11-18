require 'xmlhasher'

module SeedsHelpers

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
    
    def format_justifications(justification)
        if justification.nil? 
            return false
        else
            if justification[:p]
                justification[:p]
            elsif justification
                justification
            else
                nil 
            end
        end
    end

end
