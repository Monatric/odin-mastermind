# Computer Player Algorithm
class ComputerPlayer
  def initialize(game)
    @game = game
    @solution_list = []
    5556.times do |n|
      @solution_list.push(n + 1111)
    end
    @solution_feedback_list = %w[o o o o]
    @solution_code_counter = {}
    @solution_correct_guess_counter = {}
    @computer_guess = [0, 0, 1, 1]
    # puts @solution_list
  end

  attr_reader :computer_guess

  def guess_code
    computer_guess.each do |element|
      @game.insert_code_peg(element)
    end
    @game.current_position = 0
    @game.check_winner
  end
end
