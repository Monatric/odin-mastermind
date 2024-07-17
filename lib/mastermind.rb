require "colorize"
require_relative "display"
require "pry-byebug"
# ⚫ for key pegs

# mastermind
class Mastermind
  include Display
  RED_PEG = "⬤".colorize(:red)
  BLUE_PEG = "⬤".colorize(:blue)
  GREEN_PEG = "⬤".colorize(:green)
  MAGENTA_PEG = "⬤".colorize(:magenta)
  YELLOW_PEG = "⬤".colorize(:yellow)
  LIGHT_CYAN_PEG = "⬤".colorize(:light_cyan)
  CODE_PEGS = [RED_PEG, BLUE_PEG, GREEN_PEG, MAGENTA_PEG, YELLOW_PEG, LIGHT_CYAN_PEG].freeze

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
    set_up_board
    display_board(decode_holes, key_holes)
    while current_turn < 12
      choose_peg
      break if game_finished
    end
  end

  private

  attr_accessor :decode_holes, :key_holes, :current_position, :current_turn, :secret_code, :game_finished,
                :secret_code_counter, :correct_guess_counter

  def set_up_board
    4.times do
      secret_code.push(CODE_PEGS.sample)
    end
    12.times do
      decode_holes.push(%w[O O O O])
      key_holes.push(%w[o o o o])
    end
    puts secret_code
  end

  def choose_peg
    display_peg_options(CODE_PEGS)
    user_choice = gets.chomp
    until valid_choice?(user_choice)
      display_input_error_msg
      user_choice = gets.chomp
    end
    insert_code_peg(user_choice.to_i)
  end

  def insert_code_peg(user_choice)
    decode_holes[current_turn][current_position] = CODE_PEGS[user_choice]
    self.current_position += 1
    display_board(decode_holes, key_holes)
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
    display_board(decode_holes, key_holes)

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
    puts "Final answer? Enter 1 if yes or 0 if no."
    user_choice = gets.chomp
    until valid_confirmation?(user_choice)
      display_input_error_msg
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
end

# clean the code before proceeding to step 3
# think of how we can make another class and module to separate the code
