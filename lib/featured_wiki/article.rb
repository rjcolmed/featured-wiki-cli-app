class FeaturedWiki::Article
  attr_accessor :title, :blurb, :url

    def initialize(hash)
      hash.each { |key, value| self.send("#{key}=", value) }
    end
end
