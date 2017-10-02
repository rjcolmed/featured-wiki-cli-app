class FeaturedWiki::MostViewed < FeaturedWiki::Article
  attr_accessor :views, :featured_date

  @@all = []

    def initialize(hash)
      super
      self.views = views
    end

    def self.all
      @@all
    end

    def self.find_article_by(id)
      @@all[id - 1]
    end

    def self.create_and_save_from(hashes)
      hashes.each { |hash| @@all << self.new(hash) }
    end
end
