require_relative "mastermind"
require_relative "human_player"
require_relative "computer_player"

def select_role
  puts "Welcome to Mastermind! Enter a number to select your role."
  puts "\t1 = Code Guesser"
  puts "\t2 = Code Maker"
  user_choice = gets.to_i
  until [1, 2].include?(user_choice)
    puts "That's not an option." if user_choice != 1 || user_choice != 2
    user_choice = gets.to_i
  end
  user_choice
end

Mastermind.new(HumanPlayer, ComputerPlayer, select_role).start_game
