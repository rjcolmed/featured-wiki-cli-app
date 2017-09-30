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
          print_todays
        elsif input == "2"
          puts "8888888888888"
        elsif input == "3"
          most_viewed
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

  def generate_todays
    todays_article = FeaturedWiki::Scraper.scrape_featured_article_page
    FeaturedWiki::Article.new(todays_article)
  end

  def generate_most_viewed
    most_viewed = FeaturedWiki::Scraper.scrape_most_viewed_page
    FeaturedWiki::Article.create_most_viewed_articles(most_viewed)
  end

  def print_todays
    puts ""
    puts "///---#{generate_todays.title.upcase}---\\\\\\"
    puts ""
    puts ""
    puts "#{generate_todays.blurb}"
    puts ""
    puts "Read the full article here:"
    puts ""
    puts "#{generate_todays.url}"
    puts ""
  end

  def most_viewed
    generate_most_viewed
    puts "1. 1-10"
    puts "2. 11-20"
    puts "3. 21-30"
    puts "4. 31-40"
    puts "5. 41-50"
    puts "Enter the number corresponding to the range you'd like to see:"
    print_most_viewed(gets.chomp.to_i)
  end

  def print_most_viewed(input)
    number = input * 10
    FeaturedWiki::Article.all[number - 10...number].each.with_index(number - 9) do |article, i|
      puts "---------------------------------------------------"
      puts ""
      puts "#{i}. ///---#{article.title}---\\\\\\"
      puts ""
      puts "Featured date: #{article.featured_date}"
      puts ""
      puts "Views: #{article.views}"
      puts ""
      puts "Blurb:"
      puts ""
      puts "#{article.blurb}"
      puts ""
      puts "Read the full article here:"
      puts "#{article.url}"
      puts ""
    end
  end
end
