class FeaturedWiki::Article
  attr_accessor :title, :blurb, :url, :featured_date, :views

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

    def self.create_articles_from_collection(collection)
      collection.each do |article_hash|
        FeaturedWiki::Article.new(article_hash)
      end
    end

end
