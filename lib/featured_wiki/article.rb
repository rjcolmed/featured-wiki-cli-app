class FeaturedWiki::Article
  attr_accessor :title, :blurb, :url, :featured_date

  @@all = []

    def initialize(hash)
      hash.each { |key, value| self.send("#{key}=", value) }
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
