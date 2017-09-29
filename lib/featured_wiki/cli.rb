# CLI Controller - responsible for dealing with user input, business logic, etc.
class FeaturedWiki::CLI
  def call
    menu
  end

  def menu
    puts "\nWelcome to Today's Featured Wikipedia Article!\n\n"
    puts "Enter the number you'd like to check out:\n\n"
    puts "1. See today's featured article."
    puts "2. See the most viewed Today's Featured Wikis."
    puts "3. Get more info on Wikipedia's Today's Featured Article Section."

    puts "\nWhat would you like to do?"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
        if input == "1"
          puts ""
          puts "Title: #{todays_article.title}"
          puts ""
          puts "Blurb:"
          puts ""
          puts "#{todays_article.blurb}"
          puts ""
          puts "Read the full article here: #{todays_article.url}"
          puts ""
        elsif input == "2"
          puts "Show most viewed featured articles..."
          most_viewed_articles
          FeaturedWiki::Article.all.each.with_index(1) do |a, i|
            puts ""
            puts "#{i}. #{a.title}"
            puts ""
            puts "Featured date: #{a.featured_date}"
            puts "Views: #{a.views}"
            puts ""
            puts "Blurb:"
            puts ""
            puts "#{a.blurb}"
            puts ""
            puts "Read the full article here: #{a.url}"
            puts "===================================="
            puts ""
          end
        elsif input == "3"
          puts "Showing info on Wikipedia's Featured Article Section..."
        elsif input == "exit"
          puts "Bye!"
          exit
        else
          puts "Please enter a choice between 1 - 4 or 'exit'..."
          menu
        end
        menu
    end
  end

  def todays_article
    todays_article = FeaturedWiki::Scraper.scrape_featured_article_page
    FeaturedWiki::Article.new(todays_article)
  end

  def most_viewed_articles
    most_viewed = FeaturedWiki::Scraper.scrape_most_viewed_page
    FeaturedWiki::Article.create_most_viewed_articles(most_viewed)
  end
end
