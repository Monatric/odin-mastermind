# Board set up
class Board
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
  end

  attr_reader :secret_code, :decode_holes, :key_holes

  def set_up_board
    12.times do
      decode_holes.push(%w[O O O O])
      key_holes.push(%w[o o o o])
    end
  end

  def generate_secret_code
    4.times do
      secret_code.push(CODE_PEGS.sample)
    end
    puts secret_code
  end
end
