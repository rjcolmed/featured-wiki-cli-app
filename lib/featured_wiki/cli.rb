class FeaturedWiki::CLI
  def call
    generate_most_viewed
    generate_this_months
    puts "\nWelcome to Featured Wiki!\n\n"
    puts "Pick one of the numbers below to get started."
    menu
  end

  def menu
    puts ""
    puts "What would you like to do?"
    puts ""
    puts "1. See a blurb for today's featured Wikipedia article."
    puts "2. See blurbs for each of this month's featured articles."
    puts "3. See a list of the most viewed featured articles."

    input = nil
    while input != "exit"
      input = gets.strip.downcase
        if input == "1"
          print_todays
        elsif input == "2"
          print_this_months
        elsif input == "3"
          most_viewed_menu
        elsif input == "exit"
          puts ""
          puts "Bye!"
          puts ""
          exit
        else
          puts ""
          puts "Please enter a choice between 1 - 4 or 'exit'..."
          puts ""
          menu
        end
        puts ""
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

  def generate_this_months
    this_months = FeaturedWiki::Scraper.scrape_this_months_page
    FeaturedWiki::Article.create_this_months_articles(this_months)
  end

  def print_todays
    puts ""
    puts "///---#{generate_todays.title}---\\\\\\"
    puts ""
    puts ""
    puts "#{generate_todays.blurb}"
    puts ""
    puts "Read the full article here:"
    puts ""
    puts "#{generate_todays.url}"
    puts ""
  end

  def most_viewed_menu
    puts ""
    puts "1. 1-10"
    puts "2. 11-20"
    puts "3. 21-30"
    puts "4. 31-40"
    puts "5. 41-50"
    puts ""
    puts "Enter the number corresponding to the range you'd like to see:"
    print_most_viewed(gets.chomp.to_i)
    puts "Would you like to see more most viewed featured articles (y/n)?"
    input = gets.chomp.downcase
    input == "y" ? most_viewed_menu : menu
  end

  def print_most_viewed(input)
    number = input * 10
    FeaturedWiki::Article.all_most_viewed[number - 10...number].each.with_index(number - 9) do |a, i|
      puts "---------------------------------------------------"
      puts ""
      puts "#{i}. ///---#{a.title}---\\\\\\"
      puts ""
      puts "Featured date: #{a.featured_date}"
      puts ""
      puts "Views: #{a.views}"
      puts ""
      puts "Blurb:"
      puts ""
      puts "#{a.blurb}"
      puts ""
      puts "Read the full article here:"
      puts "#{a.url}"
      puts ""
    end
  end

  def print_this_months
    FeaturedWiki::Article.all_this_months.each do |a|
      puts "---------------------------------------------------"
      puts ""
      puts "///---#{a.title}---\\\\\\"
      puts ""
      puts "Featured date: #{a.featured_date}"
      puts ""
      puts "Blurb:"
      puts ""
      puts "#{a.blurb}"
      puts ""
      puts "Read the full article here:"
      puts "#{a.url}"
      puts ""
    end
  end
end
