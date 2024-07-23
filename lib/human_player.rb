require_relative "board"

# To initialize the human player
class HumanPlayer
  def initialize(game)
    @game = game
  end

  def choose_peg
    @game.display_peg_options(Board::CODE_PEGS)
    user_choice = gets.chomp
    until valid_choice?(user_choice)
      @game.display_input_error_msg
      user_choice = gets.chomp
    end
    # insert_code_peg(user_choice.to_i)
    user_choice.to_i - 1
  end

  # def select_secret_code
  #   @game.board.secret_code[current_turn][current_position] = Board::CODE_PEGS[user_choice]
  #   self.current_position += 1
  #   # display_board(board.decode_holes, board.key_holes)
  #   confirm_choice if current_position == 4
  # end

  # def insert_code_peg(user_choice)
  #   board.decode_holes[current_turn][current_position] = Board::CODE_PEGS[user_choice]
  #   self.current_position += 1
  #   display_board(board.decode_holes, board.key_holes)
  #   confirm_choice if current_position == 4
  # end

  def confirm_choice
    puts "Final answer? Enter 1 if yes or 0 if no."
    user_choice = gets.chomp
    until valid_confirmation?(user_choice)
      display_input_error_msg
      user_choice = gets.chomp
    end
    @game.current_position = 0
    @game.check_winner if user_choice.to_i == 1
  end

  def valid_confirmation?(user_choice)
    user_choice.match?(/[0-1]/)
  end

  def valid_choice?(user_choice)
    user_choice.match?(/[1-6]/)
  end
end
