class FeaturedWiki::CLI
  def call
    generate_most_viewed
    generate_this_months
    puts "\n●▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬๑۩ FEATUREDWIKI ۩๑▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬●\n\n"
    puts "Welcome to FeaturedWiki! Enter 1 - 3 to get started."
    menu
  end

  def menu
    puts "\n///-----------------MAIN MENU----------------\\\\\\\n\n"
    puts ""
    puts "1. Read the blurb for today's featured Wikipedia article."
    puts "2. See a list of this month's featured articles."
    puts "3. See a list of the most viewed featured articles.\n"

    input = nil
    while input != "exit"
      input = gets.strip.downcase
        case input
        when "1" then print_todays
        when "2" then this_months_menu
        when "3" then most_viewed_menu
        when "exit" then puts "\nBye!\n\n"
          exit
        else puts "\nEnter 1 - 3 or 'exit'...\n"
          menu
        end

        puts "What else would you like to do? Enter 1 - 3 or exit:"
        menu
    end
  end

  def generate_todays
    hash = FeaturedWiki::Scraper.scrape_featured_article_page
    FeaturedWiki::Article.new(hash)
  end

  def generate_this_months
    hash = FeaturedWiki::Scraper.scrape_this_months_page
    FeaturedWiki::Article.create_and_save_this_months_from(hash)
  end

  def generate_most_viewed
    hash = FeaturedWiki::Scraper.scrape_most_viewed_page
    FeaturedWiki::Article.create_and_save_most_viewed_from(hash)
  end

  def print_todays
    article = generate_todays
    puts "\n///---------------#{article.title}--------------\\\\\\\n\n"
    puts "#{article.blurb}\n\n"
    puts "Read the full article:\n"
    puts "#{article.url}\n\n"
  end

  def most_viewed_menu
    input = nil
    while input != "b"
      puts "\n///---------------Most Viewed Featured Wikipedia Articles---------------\\\\\\\n\n"
      puts "Enter the number next to the articles you'd like to see"
      puts "or b for the main menu:\n"
      puts "1. 1-10"
      puts "2. 11-20"
      puts "3. 21-30"
      puts "4. 31-40"
      puts "5. 41-50\n"
      input = gets.chomp
      input == "b" ? break : most_viewed_submenu(input.to_i); most_viewed_menu
    end
  end

  def most_viewed_submenu(input)
    pick = nil
    while pick != "b"
      print_most_viewed_list(input)
      puts ""
      puts "Enter the article's number for more info or b to go back:"
      pick = gets.chomp
      pick == "b" ? break : print_most_viewed_article(pick.to_i)
    end
  end

  def print_most_viewed_list(input)
    number = input * 10
    FeaturedWiki::Article.all_most_viewed[number - 10...number].each.with_index(number - 9) do |a, i|
      puts ""
      puts "#{i}. #{a.title}"
    end
      puts ""
  end

  def print_most_viewed_article(pick)
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
      puts "Read the full article:\n"
      puts "#{found_article.url}"
      puts ""
      puts "---------------------------------------------------"
      puts ""
  end

  def print_this_months_list
    puts "\n///-----------------#{Date.today.strftime("%B").upcase}----------------\\\\\\\n\n"
    FeaturedWiki::Article.all_this_months.each.with_index(1) do |a, i|
      puts "#{a.featured_date.split(" ").last}. #{a.title}"
    end
  end

  def this_months_menu
    input = nil
    while input != "b"
      print_this_months_list
      puts ""
      puts "Enter the day of the month next to the article you want to check out"
      puts "or b for the main menu:"
      input = gets.chomp
      input == "b" ? break : print_this_months_article(input.to_i)
    end
  end

  def print_this_months_article(input)
    article = FeaturedWiki::Article.find_this_months(input)
    puts ""
    puts "///---#{article.title}---\\\\\\"
    puts ""
    puts "Featured date: #{article.featured_date}"
    puts ""
    puts "Blurb:"
    puts ""
    puts "#{article.blurb}"
    puts ""
    puts "Read the full article:\n"
    puts "#{article.url}"
    puts ""
  end
end
