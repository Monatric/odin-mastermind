# Computer Player Algorithm
class ComputerPlayer
  def initialize(game)
    @game = game
    @solution_list = []
    @solution_feedback = %w[o o o o]
    @solution_code_counter = {}
    @solution_correct_guess_counter = {}
    @computer_guess = [1, 1, 2, 2]
    @temp_secret_code = []
  end

  def turn_on
    (1..6).each do |i|
      (1..6).each do |j|
        (1..6).each do |k|
          (1..6).each do |l|
            solution_list << [i, j, k, l]
          end
        end
      end
    end
  end

  def guess_code
    computer_guess.each do |element|
      @game.insert_code_peg(element)
    end
    @game.current_position = 0
    @game.check_winner
    compare_game_feedback_to_solution_feedback
    self.computer_guess = solution_list[0]
    computer_guess
  end

  private

  attr_accessor :computer_guess, :solution_code_counter,
                :solution_correct_guess_counter, :temp_secret_code,
                :solution_list, :solution_feedback

  def compare_game_feedback_to_solution_feedback
    new_solution = solution_list.select do |element|
      game_feedback = @game.board.key_holes[@game.current_turn - 1]
      self.temp_secret_code = element
      give_feedback
      keep_this_element = element if game_feedback == solution_feedback
      self.solution_feedback = %w[o o o o]
      keep_this_element
    end

    self.solution_list = new_solution
  end

  def compare_guess_to_solution(solution_feedback)
    solution_list.each do |element|
      insert_temp_code(element)
    end
  end

  def insert_temp_code(temp_code)
    self.temp_secret_code = temp_code
  end

  def give_feedback
    self.solution_code_counter = temp_secret_code.tally
    give_black_feedback
    give_white_feedback
  end

  def count_keys(element)
    if solution_correct_guess_counter.key?(element)
      solution_correct_guess_counter[element] += 1
    else
      solution_correct_guess_counter[element] = 1
    end
  end

  def give_black_feedback
    computer_guess.each_with_index do |element, index|
      next unless temp_secret_code[index] == element

      solution_feedback.unshift(Board::KEY_PEGS[0]).pop
      count_keys(element)
    end
  end

  def guess_greater_than_solution?(element)
    solution_code_counter[element] < solution_correct_guess_counter[element]
  end

  def give_white_feedback
    computer_guess.each_with_index do |element, index|
      next if solution_code_counter.key?(element) == false

      next if temp_secret_code[index] == element

      count_keys(element)

      next if guess_greater_than_solution?(element)

      solution_feedback.unshift(Board::KEY_PEGS[1]).pop
    end
    self.solution_correct_guess_counter = {}
  end
end
