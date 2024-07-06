require "colorize"
# ⚫ for key pegs

# mastermind
class Mastermind
  # Code pegs
  RED_PEG = "⬤".colorize(:red)
  BLUE_PEG = "⬤".colorize(:blue)
  GREEN_PEG = "⬤".colorize(:green)
  MAGENTA_PEG = "⬤".colorize(:magenta)
  YELLOW_PEG = "⬤".colorize(:yellow)
  CYAN_PEG = "⬤".colorize(:cyan)
  CODE_PEGS = [RED_PEG, BLUE_PEG, GREEN_PEG, YELLOW_PEG, CYAN_PEG].freeze

  # Key pegs
  BLACK_PEG = "⬤".colorize(:black)
  WHITE_PEG = "⬤".colorize(:white)
  KEY_PEGS = [BLACK_PEG, WHITE_PEG].freeze

  def test
    puts "Test"
  end
end

test = Mastermind.new
test.test
