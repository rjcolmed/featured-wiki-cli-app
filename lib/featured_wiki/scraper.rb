class FeaturedWiki::Scraper

  BASE_URL = "https://en.wikipedia.org"
  MOST_VIEWED_URL = "/wiki/Wikipedia:Today%27s_featured_article/Most_viewed"

  def self.scrape_main_page
    doc = Nokogiri::HTML(open(BASE_URL))
    articles = doc.css("div.tfa-recent a").map do |a|
      title = a.text
      url = BASE_URL + a["href"]
      { title: title, url: url }
    end

    {
      todays_title: doc.at_css("div#mp-tfa b a").attribute("title").text,
      todays_blurb: doc.css("div#mp-tfa").text.split(" (Full").shift,
      todays_url: BASE_URL + doc.css("div#mp-tfa a.mw-redirect").attribute("href").text,
      recently_featured: articles
    }
  end

  #most viewed stats
  #title
  #featured date
  #number of views
  #blurb
  #url


  def self.scrape_most_viewed_page
    doc = Nokogiri::HTML(open(BASE_URL + MOST_VIEWED_URL))

    articles = doc.css("table").map do |table|
      most_viewed = []
      table.css("tr").each do |row|
        article = {}
        row.css("td").each_with_index do |col, i|
          if i == 0
              article[:title] = col.css("a").text
              article[:url] = BASE_URL + col.css("a").attribute("href").text
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
