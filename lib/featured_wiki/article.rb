class FeaturedWiki::Article
  attr_accessor :todays_title, :todays_summary, :todays_url, :recently_featured_titles, :recently_featured_urls

  @@all = []
  BASE_URL = "https://en.wikipedia.org"

    def initialize(article_hash)
      article_hash.each { |key, value| self.send("#{key}=", value) }
      @@all << self
    end

    def self.all
      @@all
    end

    def self.today
      # scrape wikipedia and return title, summary, and url of Today's featured article
      self.scrape_main_page(BASE_URL)
    end

    def self.recently_featured
      self.scrape_main_page(BASE_URL)
    end

    def self.scrape_main_page(main_page_url)
      doc = Nokogiri::HTML(open(main_page_url))

      titles = []
      urls = []
      doc.css("div.tfa-recent a").each do |link|
        titles << link.text
        urls << BASE_URL + link["href"]
      end

      data = {
        :todays_title => doc.css("div#mp-tfa b a").shift.attribute("title").text,
        :todays_summary => doc.css("div#mp-tfa").text.split(" (Full").shift,
        :todays_url => BASE_URL + doc.css("div#mp-tfa a.mw-redirect").attribute("href").text,
        :recently_featured_titles => titles,
        :recently_featured_urls => urls
      }
    end

end
