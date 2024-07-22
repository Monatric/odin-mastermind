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
end
