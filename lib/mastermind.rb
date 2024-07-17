require "colorize"
require "pry-byebug"
# ⚫ for key pegs

# mastermind
class Mastermind
  # Code pegs
  RED_PEG = "⬤".colorize(:red)
  BLUE_PEG = "⬤".colorize(:blue)
  GREEN_PEG = "⬤".colorize(:green)
  MAGENTA_PEG = "⬤".colorize(:magenta)
  YELLOW_PEG = "⬤".colorize(:yellow)
  LIGHT_CYAN_PEG = "⬤".colorize(:light_cyan)
  CODE_PEGS = [RED_PEG, BLUE_PEG, GREEN_PEG, MAGENTA_PEG, YELLOW_PEG, LIGHT_CYAN_PEG].freeze

  # Key pegs
  BLACK_PEG = "⬤".colorize(:black)
  WHITE_PEG = "⬤".colorize(:white)
  KEY_PEGS = [BLACK_PEG, WHITE_PEG].freeze

  def initialize
    @secret_code = []
    @decode_holes = []
    @key_holes = []
    @secret_code_counter = {}
    @correct_guess_counter = {}
    @current_turn = 0
    @current_position = 0
    @game_finished = false
  end

  def start_game
    puts "Welcome to Mastermind! The computer has already selected the secret colors. Try your best to guess!"
    12.times do
      decode_holes.push(%w[O O O O])
      key_holes.push(%w[o o o o])
    end
    create_secret_code
    show_board
    while current_turn < 12
      choose_peg
      break if game_finished
    end
  end

  private

  attr_accessor :decode_holes, :key_holes, :current_position, :current_turn, :secret_code, :game_finished,
                :secret_code_counter, :correct_guess_counter

  def create_secret_code
    4.times do
      secret_code.push(CODE_PEGS.sample)
    end
    puts secret_code
  end

  def show_board
    puts "\nCode holes\tKey holes"
    12.times do |n|
      print "#{decode_holes[n][0]} #{decode_holes[n][1]} #{decode_holes[n][2]} #{decode_holes[n][3]}\t\t"
      puts "#{key_holes[n][0]} #{key_holes[n][1]} #{key_holes[n][2]} #{key_holes[n][3]}\n"
    end
  end

  def choose_peg
    show_peg_options
    user_choice = gets.chomp
    until valid_choice?(user_choice)
      puts input_error_msg
      user_choice = gets.chomp
    end
    insert_code_peg(user_choice.to_i)
  end

  def insert_code_peg(user_choice)
    decode_holes[current_turn][current_position] = CODE_PEGS[user_choice]
    self.current_position += 1
    show_board
    confirm_choice if current_position == 4
  end

  def code_guessed?
    decode_holes[current_turn] == secret_code
  end

  def check_winner
    if current_turn == 11 && code_guessed? == false
      puts "Computer has won! Better luck next time."
      self.game_finished = true
    elsif code_guessed? == true
      puts "Congratulations player!"
      self.game_finished = true
    else
      give_feedback
      choose_peg
    end
  end

  def give_feedback
    self.secret_code_counter = secret_code.tally
    give_black_feedback
    give_white_feedback
    show_board

    self.current_turn += 1
  end

  def count_keys(decode_element)
    if correct_guess_counter.key?(decode_element)
      correct_guess_counter[decode_element] += 1
    else
      correct_guess_counter[decode_element] = 1
    end
  end

  def give_black_feedback
    decode_holes[current_turn].each_with_index do |decode_element, index|
      # index element of the secret_code is the same as decode_holes
      next unless secret_code[index] == decode_element

      key_holes[current_turn].unshift(KEY_PEGS[0]).pop
      count_keys(decode_element)
    end
  end

  def give_white_feedback
    decode_holes[current_turn].each do |decode_element|
      next if secret_code_counter.key?(decode_element) == false

      count_keys(decode_element)

      next if secret_code_counter[decode_element] < correct_guess_counter[decode_element]

      key_holes[current_turn].unshift(KEY_PEGS[1]).pop
    end
    # reset the counter every turn
    self.correct_guess_counter = {}
  end

  def confirm_choice
    show_board
    puts "Final answer? Enter 1 if yes or 0 if no."
    user_choice = gets.chomp
    until valid_confirmation?(user_choice)
      puts input_error_msg
      user_choice = gets.chomp
    end
    self.current_position = 0
    check_winner if user_choice.to_i == 1
  end

  def valid_confirmation?(user_choice)
    user_choice.match?(/[0-1]/)
  end

  def valid_choice?(user_choice)
    user_choice.match?(/[0-5]/)
  end

  def input_error_msg
    puts "That's not a number between 0 to 5!"
  end

  def show_peg_options
    puts "Below are the color options. Choose a number that aligns with the color."
    puts "0  1  2  3  4  5 \t  6"
    6.times do |n|
      print "#{CODE_PEGS[n]}  "
    end
    puts "\tundo"
  end
end

# clean the code before proceeding to step 3
# think of how we can make another class and module to separate the code
