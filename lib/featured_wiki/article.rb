class FeaturedWiki::Article
  attr_accessor :title, :summary, :url

  @@all = []
  @@base_url = "https://en.wikipedia.org"

    def initialize(article_hash)
      article_hash.each { |key, value| self.send("#{key}=", value) }
      @@all << self
    end

    def self.all
      @@all
    end

    def self.today
      # scrape wikipedia and return title, summary, and url of Today's featured article
      self.scrape_main_page("https://en.wikipedia.org/wiki/Main_Page")
    end

    #title: doc.css("div#mp-tfa b a").shift.attribute("title").text
    #summary: doc.css("div#mp-tfa").text.split(" (Full").shift
    #url: doc.css("div#mp-tfa a.mw-redirect").attribute("href").text

    def self.scrape_main_page(main_page_url)

      doc = Nokogiri::HTML(open(main_page_url))
        {
          :title => doc.css("div#mp-tfa b a").shift.attribute("title").text,
          :summary => doc.css("div#mp-tfa").text.split(" (Full").shift,
          :url => @@base_url << doc.css("div#mp-tfa a.mw-redirect").attribute("href").text
        }
    end

end
