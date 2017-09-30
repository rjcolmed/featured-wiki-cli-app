class FeaturedWiki::CLI
  def call
    menu
  end

  def menu
    puts "\nWelcome to Featured Wiki!\n\n"
    puts "Enter a number to get started:\n\n"
    puts "1. See a blurb for today's featured Wikipedia article."
    puts "2. See blurbs for each of this month's featured articles."
    puts "3. See a list of the most viewed featured articles."

    puts "\nWhat would you like to do?"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
        if input == "1"
          print_todays_article
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
          results = FeaturedWiki::Scraper.scrape_this_months_page #added
          results.each do |result|
            puts "#{result}"
          end
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

  def print_todays_article
    puts ""
    puts "///---#{todays_article.title.upcase}---\\\\\\"
    puts ""
    puts ""
    puts "#{todays_article.blurb}"
    puts ""
    puts "Read the full article here:"
    puts ""
    puts "#{todays_article.url}"
    puts ""
  end
end
