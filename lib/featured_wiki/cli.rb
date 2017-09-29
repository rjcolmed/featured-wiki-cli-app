# CLI Controller - responsible for dealing with user input, business logic, etc.
class FeaturedWiki::CLI
  def call
    menu
  end

  def menu
    puts "\nWelcome to Featured Wiki!\n\n"
    puts "Enter the number you'd like to check out:\n\n"
    puts "1. See today's featured wiki article."
    puts "2. Choose from a few recently featured articles."
    puts "3. View this month's featured article queue."
    puts "4. Get info on Wikipedia's Featured Article Section."

    puts "\nWhat would you like to do?"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
        if input == "1"
          puts "Showing today's article...\n"
        elsif input == "2"
          puts "Listing recently featured articles...\n"
        elsif input == "3"
          puts "Show most viewed featured articles..."
          results = FeaturedWiki::Scraper.scrape_most_viewed_page
        elsif input == "4"
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

    def display
    end
  end
end
