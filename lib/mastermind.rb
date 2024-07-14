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

  attr_accessor :decode_holes, :key_holes, :current_position, :current_turn, :secret_code

  def initialize
    @secret_code = []
    @decode_holes = []
    @key_holes = []
    @current_turn = 0
    @current_position = 0
  end

  def start_game
    puts "Welcome to Mastermind! The computer has already selected the secret colors. Try your best to guess!"
    12.times do
      decode_holes.push(%w[O O O O])
      key_holes.push(%w[o o o o])
    end
    create_secret_code
    show_board
    choose_peg while current_turn < 12
  end

  def create_secret_code
    4.times do |n|
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
    show_board
  end

  def insert_code_peg(user_choice)
    decode_holes[current_turn][current_position] = CODE_PEGS[user_choice]
    self.current_position += 1
    confirm_choice if current_position == 4
  end

  def code_guessed?
    true if decode_holes[current_turn] == secret_code[current_turn]
  end

  def check_winner
    if current_turn == 12 && code_guessed? == false
      puts "Computer has won! Better luck next time."
    elsif code_guessed? == true
      puts "Congratulations player!"
    else
      give_feedback
      choose_peg
    end
  end

  def give_feedback
    # binding.pry
    give_black_feedback
    give_white_feedback
    puts "test #{key_holes[current_turn][0]} #{key_holes[current_turn][1]} #{key_holes[current_turn - 1][2]} #{key_holes[current_turn - 1][3]}"
    show_board

    self.current_turn += 1
  end

  def give_black_feedback
    decode_holes[current_turn].each_with_index do |decode_element, index|
      # index element of the secret_code is the same as decode_holes
      if secret_code[index] == decode_element
        key_holes[current_turn].unshift(KEY_PEGS[0])
        key_holes[current_turn].pop
      end
    end
  end

  def give_white_feedback
    tallied_secret_code = secret_code.tally
    tallied_decode_holes = decode_holes[current_turn].tally
    temp_decode_holes = {}
    puts tallied_secret_code
    puts tallied_decode_holes
    decode_holes[current_turn].each_with_index do |decode_element, index|
      if temp_decode_holes.key?(decode_element)
        temp_decode_holes[decode_element] += 1
      else
        temp_decode_holes[decode_element] = 1
      end

      # index element of the secret_code is the same as decode_holes
      if secret_code[index] == decode_element
        # binding.pry
        next
      elsif decode_holes[current_turn].any?(secret_code[index])
        next if tallied_secret_code.key?(decode_element) == false

        # change the logic to hash of decode holes where
        # inserts a white if the value of the key of secret is greater than decode
        # add +1 to that key of decode holes
        next if tallied_secret_code[decode_element] < temp_decode_holes[decode_element]

        key_holes[current_turn].unshift(KEY_PEGS[1])
        key_holes[current_turn].pop

      end
    end
    temp_decode_holes = {}
  end

  def confirm_choice
    show_board
    puts "Final answer? Enter 1 if yes or 0 if no."
    user_choice = gets.chomp
    until valid_confirmation?(user_choice)
      puts input_error_msg(user_input)
      user_choice = gets.chomp
    end
    self.current_position = 0
    check_winner if user_choice.to_i == 1
  end

  # def current_turn
  #   1
  # end

  # def current_position(increment)
  #   0 + increment
  # end

  def valid_confirmation?(valid_confirmation)
    valid_confirmation.match?(/[0-1]/)
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

  def test
    p decode_holes
  end
end

test = Mastermind.new
test.start_game
test.show_board
