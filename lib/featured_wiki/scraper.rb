class FeaturedWiki::Scraper

  BASE_URL = "https://en.wikipedia.org/wiki/Wikipedia:Today%27s_featured_article"
  HOME_URL = "https://en.wikipedia.org"
  DATE_PATH = "/#{Date.today.strftime("%B")}_#{Date.today.day},_#{Date.today.year}"
  MONTH_PATH = "/#{Date.today.strftime("%B")}_#{Date.today.year}"
  MOST_VIEWED_PATH = "/Most_viewed"

  def self.scrape_featured_article_page
    doc = Nokogiri::HTML(open(BASE_URL + DATE_PATH))

    {
      title: doc.css("p a").first.text,
      blurb: doc.css("p").text.split(" (Full").first,
      url: HOME_URL + doc.css("p a").first["href"],
    }
  end

  def self.scrape_this_months_page
    doc = Nokogiri::HTML(open(BASE_URL + MONTH_PATH))
    doc.css("div#mp-tfa-img + p, dl + p").each_with_index.map do |p, i|
        doc.css("dt b")[i] ? d = doc.css("dt b")[i].text : d = "No date found"
        p.at_css('a:has(b)') ? t = p.css('a:has(b)').attribute('title').text : t = "No title found"
        p ? b = p.text.split(" (Full").first : b = "No blurb found"
        p.at_css('a:has(b)') ? u = HOME_URL + p.css('a:has(b)').attribute('href').text : u = "No URL found"

        { featured_date: d, title: t, blurb: b, url: u }
    end
  end

  def self.scrape_most_viewed_page
    doc = Nokogiri::HTML(open(BASE_URL + MOST_VIEWED_PATH))
    most_viewed = []
    doc.css("table").each do |table|
      table.css("tr").each do |row|
        article = {}
        row.css("td").each_with_index do |col, i|
          if i == 0
              article[:title] = col.css("a").text
              article[:url] = HOME_URL + col.css("a").attribute("href").text
              article[:featured_date] = col.css("small").text
          elsif i == 2
            article[:views] = col.css("a").text + " " + col.css("small").text
          elsif i == 3
            article[:blurb] = col.text
          end
        end
        most_viewed << article
      end
    end
    most_viewed.drop(1)
  end
end
