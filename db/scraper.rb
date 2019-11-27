require 'nokogiri'
require 'open-uri'

module Scraper

    BASE_GALLERY_URL = 'https://whc.unesco.org/en/list'
    BASE_IMG_URL = 'http://whc.unesco.org'

    def get_site_image(unesco_id_number)
        page_url = self.generate_page_url(unesco_id_number)
        doc = get_page(page_url)
        img_path = get_image_path(doc, unesco_id_number)
       
        if img_path == false
            return "https://pmdvod.nationalgeographic.com/NG_Video/607/426/lgpost_1526064084127.jpg"
        end

        img_url = generate_img_url(img_path)
    end

    def generate_page_url(unesco_id_number)
        "#{BASE_GALLERY_URL}/#{unesco_id_number}/gallery/1"
    end

    def get_page(page_url)
        Nokogiri::HTML(open(page_url))
    end

    def get_image_path(doc, unesco_id_number)
        if doc.css(".bordered.icaption.nomargin.nopadding").css(".lightbox").css("img").count > 0
            return doc.css(".bordered.icaption.nomargin.nopadding").css(".lightbox").css("img").first.attributes.first.second.value
        elsif !doc.css(".bordered.icaption.nomargin.nopadding").css(".lightbox").css("img")
            page_url = "#{BASE_GALLERY_URL}/#{unesco_id_number}/gallery"
            doc = Nokogiri::HTML(open(page_url))
            return doc.css("a.lightbox > img").first.attributes["data-src"].value
        else
            return false
        end
    end

    def generate_img_url(img_path)
        "#{BASE_IMG_URL}#{img_path}"
    end

end






