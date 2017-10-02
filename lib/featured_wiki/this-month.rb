class FeaturedWiki::ThisMonth < FeaturedWiki::Article
  attr_accessor :featured_date

  @@all = []

    def initialize(hash)
      super
      self.featured_date  = featured_date
    end

    def self.all
      @@all
    end

    def self.find_article_by(id)
      @@all[id - 1]
    end

    def self.create_and_save_from(collection)
      collection.each { |hash| @@all << self.new(hash) }
    end
end
