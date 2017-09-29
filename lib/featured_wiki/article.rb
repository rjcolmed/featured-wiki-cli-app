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

    def self.create_most_viewed_articles(collection)
      collection.each { |article_hash| self.new(article_hash) }
    end

end
