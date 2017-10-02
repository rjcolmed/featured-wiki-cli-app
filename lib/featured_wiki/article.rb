class FeaturedWiki::Article
  attr_accessor :title, :blurb, :url, :featured_date, :views

  @@all_most_viewed = []
  @@all_this_months = []

    def initialize(hash)
      hash.each { |key, value| self.send("#{key}=", value) }
    end

    def self.all_most_viewed
      @@all_most_viewed
    end

    def self.all_this_months
      @@all_this_months
    end

    def self.find_most_viewed(i)
      @@all_most_viewed[i - 1]
    end

    def self.find_this_months(i)
      @@all_this_months[i - 1]
    end

    def self.create_and_save_most_viewed_from(collection)
      collection.each { |hash| @@all_most_viewed << self.new(hash) }
    end

    def self.create_and_save_this_months_from(collection)
      collection.each { |hash| @@all_this_months << self.new(hash) }
    end
end
