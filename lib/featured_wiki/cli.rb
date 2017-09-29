# CLI Controller - responsible for dealing with user input, business logic, etc.
class FeaturedWiki::CLI
  def call
    menu
  end

  def menu
    puts "\nWelcome to Today's Featured Wiki!\n\n"
    puts "Enter the number you'd like to check out:\n\n"
    puts "1. See today's featured wiki article."
    puts "2. View this month's featured article queue."
    puts "3. Get info on Wikipedia's Featured Article Section."

    puts "\nWhat would you like to do?"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
        if input == "1"
          puts "#{todays_article.title}"
          puts "#{todays_article.blurb}"
          puts "Read the full article at: #{todays_article.url}"
        elsif input == "2"
          puts "Show most viewed featured articles..."
          most_viewed_articles
          FeaturedWiki::Article.all.each.with_index(1) do |a, i|
            puts "#{i}. #{a.title}"
            puts "#{a.featured_date}"
            puts "#{a.views}"
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
