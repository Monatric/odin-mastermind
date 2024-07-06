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

  attr_accessor :decode_holes, :key_holes

  def initialize
    @secret_code = []
    @decode_holes = []
    @key_holes = []
  end

  def start_game
    12.times do
      decode_holes.push(%w[O O O O])
      key_holes.push(%w[o o o o])
    end
  end

  def test
    p decode_holes
  end
end

test = Mastermind.new
test.test
test.start_game
test.test
