class FeaturedWiki::Scraper

  BASE_URL = "https://en.wikipedia.org/wiki/Wikipedia:Today%27s_featured_article"
  HOME_URL = "https://en.wikipedia.org"
  DATE_PATH = "/#{Date.today.strftime("%B")}_#{Date.today.day},_#{Date.today.year}"
  MOST_VIEWED_PATH = "/Most_viewed"


  def self.scrape_featured_article_page
    doc = Nokogiri::HTML(open(BASE_URL + DATE_PATH))

    {
      title: doc.css("p a").first.text,
      blurb: doc.css("p").text.split(" (Full").first,
      url: HOME_URL + doc.css("p a").first["href"],
    }
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
