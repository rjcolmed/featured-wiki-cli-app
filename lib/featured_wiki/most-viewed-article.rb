class FeaturedWiki::MostViewedArticle < FeaturedWiki::Article
  attr_accessor :views

  @@all_most_viewed = []

    def initialize(hash)
      super
      self.views = views
    end

    def self.all_most_viewed
      @@all_most_viewed
    end

    def self.find_article_by(id)
      @@all_most_viewed[id - 1]
    end

    def self.create_and_save_from(hashes)
      hashes.each { |hash| @@all_most_viewed << self.new(hash) }
    end
end
