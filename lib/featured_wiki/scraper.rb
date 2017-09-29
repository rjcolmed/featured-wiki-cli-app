class FeaturedWiki::Scraper

  BASE_URL = "https://en.wikipedia.org/wiki/Wikipedia:Today%27s_featured_article/"
  DATE_PATH = "#{Date.today.strftime("%B")}_#{Date.today.day},_#{Date.today.year}"
  MOST_VIEWED_PATH = "Most_viewed"
  HOME_URL = "https://en.wikipedia.org"

  def self.scrape_featured_article_page
    doc = Nokogiri::HTML(open(BASE_URL + DATE_PATH))

    articles = doc.css("div.tfa-recent a").map do |a|
      title = a.text
      url = HOME_URL + a["href"]
      { title: title, url: url }
    end

    {
      title: doc.css("p a").first.text,
      blurb: doc.css("p").text.split(" (Full").first,
      url: HOME_URL + doc.css("p a").first["href"],
      recently_featured: articles
    }
  end

  def self.scrape_most_viewed_page
    doc = Nokogiri::HTML(open(BASE_URL + MOST_VIEWED_PATH))

    articles = doc.css("table").map do |table|
      most_viewed = []
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
      most_viewed
    end
  end

end
