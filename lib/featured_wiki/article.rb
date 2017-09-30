class FeaturedWiki::Article
  attr_accessor :title, :blurb, :url, :featured_date, :views

  @@all_most_viewed = []
  @@all_this_months = [] #added

    def initialize(hash)
      hash.each { |key, value| self.send("#{key}=", value) }
    end

    def self.all_most_viewed
      @@all_most_viewed
    end

    def self.all_this_months
      @@all_this_months
    end

    def self.create_most_viewed_articles(collection)
      collection.each { |hash| @@all_most_viewed << self.new(hash) }
    end

    def self.create_this_months_articles(collection) #added
      collection.each { |hash| @@all_this_months << self.new(hash) }
    end
end
