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

        justification_to_return = ""

        if justification.nil? 
            justification_to_return = "N/A"
        elsif justification[:p]
            justification_to_return = justification[:p]
        else 
            justification_to_return = justification
        end

        if justification_to_return.class == Array
            justification_to_return = justification_to_return.join(" ")
        end

        return justification_to_return.strip

    end

    def format_short_description(site)
        
        description_to_return = ""
   
        if !site[:short_description] 
            return "N/A"
        end

        if site[:short_description].class == String 
            return site[:short_description]
        end

        if site[:short_description].class == Array 
            return site[:short_description].join("\n")
        end

        if !site[:short_description][:p] 
            return site[:short_description]
        end

        if site[:short_description][:p].class == String 
            return site[:short_description][:p]
        end
        
        if site[:short_description][:p].class == Array
            return site[:short_description][:p].join("\n")
        end

        if site[:short_description][:p][:span].class == String 
            return site[:short_description][:p][:span]
        end
        if site[:short_description][:p][:span].class == Array 
            return site[:short_description][:p][:span].join("\n")
        end

        return "N/A"

    end

end
