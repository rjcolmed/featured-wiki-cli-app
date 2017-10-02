class FeaturedWiki::Scraper

  HOME_URL = "https://en.wikipedia.org"
  MONTH_PATH = "/#{Date.today.strftime("%B")}_#{Date.today.year}"
  BASE_URL = "https://en.wikipedia.org/wiki/Wikipedia:Today%27s_featured_article"
  DATE_PATH = "/#{Date.today.strftime("%B")}_#{Date.today.day},_#{Date.today.year}"

  def self.scrape_this_months_page
    doc = Nokogiri::HTML(open(BASE_URL + MONTH_PATH))
    doc.css("div#mp-tfa-img + p, dl + p").each_with_index.map do |p, i|
        p ? b = p.text.split(" (Full").first : b = "No blurb found"
        doc.css("dt b")[i] ? d = doc.css("dt b")[i].text : d = "No date found"
        p.at_css("a:has(b)") ? t = p.css("a:has(b)")[0]["title"] : t = "No title found"
        p.at_css("a:has(b)") ? u = HOME_URL + p.css("a:has(b)")[0]["href"] : u = "No URL found"

        { featured_date: d, title: t, blurb: b, url: u }
    end
  end

  def self.scrape_most_viewed_page
    doc = Nokogiri::HTML(open(BASE_URL + "/Most_viewed"))

    most_viewed = []
    tables = doc.css("table")
    tables.css("tr").each do |row|
      article = {}
      row.css("td").each_with_index do |col, i|
        case i
        when 0
          article[:title] = col.css("a").text
          article[:featured_date] = col.css("small").text
          article[:url] = "#{HOME_URL}#{col.css("a")[0]["href"]}"
        when 2
          article[:views] = "#{col.css("a").text} #{col.css("small").text}"
        when 3
          article[:blurb] = col.text
        end
      end
      most_viewed << article
    end
    most_viewed.drop(1)
  end

end
