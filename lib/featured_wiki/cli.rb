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
          todays_featured = FeaturedWiki::Article.new(FeaturedWiki::Article.today)
          puts "#{todays_featured.title}"
          puts "#{todays_featured.summary}"
          puts "#{todays_featured.url}"
        elsif input == "2"
          puts "Listing recently featured articles..."
        elsif input == "3"
          puts "Showing this month's queue..."
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
