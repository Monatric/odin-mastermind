require "colorize"
require_relative "display"
require "pry-byebug"
require_relative "board"
# ⚫ for key pegs

# mastermind
class Mastermind
  include Display

  def initialize(player_1_class)
    @players = player_1_class.new(self)
    @board = Board.new
    @secret_code_counter = {}
    @correct_guess_counter = {}
    @current_turn = 0
    @current_position = 0
    @game_finished = false
  end

  def start_game(player_role)
    # puts "Welcome to Mastermind! The computer has already selected the secret colors. Try your best to guess!"
    board.set_up_board
    select_player_role(player_role)
    display_board(board.decode_holes, board.key_holes)
    # while current_turn < 12
    #   user_choice = players.choose_peg
    #   insert_code_peg(user_choice)
    #   break if game_finished
    # end
  end

  attr_accessor :current_position

  def check_winner
    if current_turn == 11 && code_guessed? == false
      puts "Computer has won! Better luck next time."
      self.game_finished = true
    elsif code_guessed? == true
      puts "Congratulations player!"
      self.game_finished = true
    else
      give_feedback
      # players.choose_peg
    end
  end

  private

  attr_accessor :current_turn, :game_finished,
                :secret_code_counter, :correct_guess_counter, :board, :players

  def select_player_role(player_role)
    if player_role == 1
      board.generate_secret_code
      while current_turn < 12
        user_choice = players.choose_peg
        insert_code_peg(user_choice)
        break if game_finished
      end
    elsif player_role == 2
      players.select_secret_code
      puts board.secret_code
    end
  end

  def insert_code_peg(user_choice)
    board.decode_holes[current_turn][current_position] = Board::CODE_PEGS[user_choice]
    self.current_position += 1
    display_board(board.decode_holes, board.key_holes)
    players.confirm_choice if current_position == 4
  end

  def code_guessed?
    board.decode_holes[current_turn] == board.secret_code
  end

  def give_feedback
    self.secret_code_counter = board.secret_code.tally
    give_black_feedback
    give_white_feedback
    display_board(board.decode_holes, board.key_holes)

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
    board.decode_holes[current_turn].each_with_index do |decode_element, index|
      # index element of the secret_code is the same as decode_holes
      next unless board.secret_code[index] == decode_element

      board.key_holes[current_turn].unshift(Board::KEY_PEGS[0]).pop
      count_keys(decode_element)
    end
  end

  def guess_greater_than_secret?(decode_element)
    secret_code_counter[decode_element] < correct_guess_counter[decode_element]
  end

  def give_white_feedback
    # binding.pry
    board.decode_holes[current_turn].each do |decode_element|
      next if secret_code_counter.key?(decode_element) == false

      count_keys(decode_element)

      next if guess_greater_than_secret?(decode_element)

      board.key_holes[current_turn].unshift(Board::KEY_PEGS[1]).pop
    end
    # reset the counter every turn
    self.correct_guess_counter = {}
  end
end
