# Displaying texts
module Display
  def display_peg_options(code_pegs)
    puts "Below are the color options. Choose a number that aligns with the color."
    puts "0  1  2  3  4  5 \t  6"
    6.times do |n|
      print "#{code_pegs[n]}  "
    end
    puts "\tundo"
  end

  def input_error_msg
    puts "That's not a number between the options!"
  end
end
