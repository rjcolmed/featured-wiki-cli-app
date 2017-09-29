class FeaturedWiki::Article
  attr_accessor :title, :blurb, :url

  @@all = []

    def initialize(article_hash)
      article_hash.each { |key, value| self.send("#{key}=", value) }
      @@all << self
    end

    def self.all
      @@all
    end

    def create_todays_article(article_hash)
      self.new
    end

    def add_attributes_for_most_viewed
    end
end
