class FeaturedWiki::Article
  attr_accessor :title, :summary, :url

  @@all = []

    def initialize(article_hash)
      article_hash.each { |key, value| self.send("#{key}=", value) }
      @@all << self
    end

    def self.all
      @@all
    end

end
