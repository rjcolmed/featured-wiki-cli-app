class FeaturedWiki::CLI
  def call
    puts "\nWelcome to Featured Wiki!\n\n"
    puts "Pick one of the numbers below to get started."
    generate_most_viewed
    generate_this_months
    menu
  end

  def menu
    puts ""
    puts "1. See a blurb for today's featured Wikipedia article."
    puts "2. See a list of this month's featured articles."
    puts "3. See a list of the most viewed featured articles."

    input = nil
    while input != "exit"
      input = gets.strip.downcase
        case input
        when "1"
          print_todays
        when "2"
          print_this_months
        when "3"
          most_viewed_menu
        when "exit"
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
        puts "What else would you like to do?"
        menu
    end
  end

  def generate_todays
    todays_article = FeaturedWiki::Scraper.scrape_featured_article_page
    FeaturedWiki::Article.new(todays_article)
  end

  def generate_most_viewed
    most_viewed = FeaturedWiki::Scraper.scrape_most_viewed_page
    FeaturedWiki::Article.create_and_save_most_viewed_from(most_viewed)
  end

  def generate_this_months
    this_months = FeaturedWiki::Scraper.scrape_this_months_page
    FeaturedWiki::Article.create_and_save_this_months_from(this_months)
  end

  def print_todays
    puts ""
    puts "///---#{generate_todays.title}---\\\\\\"
    puts ""
    puts ""
    puts "#{generate_todays.blurb}"
    puts ""
    puts "Read the full article here:"
    puts "#{generate_todays.url}"
    puts ""
  end

  def most_viewed_menu
    puts "Enter the number next to the articles you'd like to see:"
    puts "or 'exit' for the main menu:"
    puts ""
    puts "1. 1-10"
    puts "2. 11-20"
    puts "3. 21-30"
    puts "4. 31-40"
    puts "5. 41-50"
    puts ""

    input = gets.chomp.to_i
    input == 0 ? menu : most_viewed_submenu(input)
  end

  def most_viewed_submenu(input)
    pick = nil
    while pick != 0
      print_most_viewed_list(input)
      puts ""
      puts "Enter the article's number for more info"
      puts "or b to go back:"
      pick = gets.chomp.to_i
      print_article(pick)
    end
  end

  def print_most_viewed_list(input)
    number = input * 10
    FeaturedWiki::Article.all_most_viewed[number - 10...number].each.with_index(number - 9) do |a, i|
      puts "#{i}. #{a.title}"
      puts ""
    end
  end

  def print_article(pick)
    binding.pry
    found_article = FeaturedWiki::Article.find_most_viewed(pick)
      puts "---------------------------------------------------"
      puts ""
      puts "///---#{found_article.title}---\\\\\\"
      puts ""
      puts "Featured date: #{found_article.featured_date}"
      puts ""
      puts "Views: #{found_article.views}"
      puts ""
      puts "Blurb:"
      puts ""
      puts "#{found_article.blurb}"
      puts ""
      puts "Read the full article here:"
      puts "#{found_article.url}"
      puts ""
      puts "---------------------------------------------------"
      puts ""
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
