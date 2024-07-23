# Displaying texts
module Display
  def display_peg_options(code_pegs)
    puts "Below are the color options. Choose a number that aligns with the color."
    puts "1  2  3  4  5  6 \t  7"
    6.times do |n|
      print "#{code_pegs[n]}  "
    end
    puts "\tundo"
  end

  def display_input_error_msg
    puts "That's not a number between the options!"
  end

  def display_board(decode_holes, key_holes)
    puts "\nCode holes\tKey holes"
    12.times do |n|
      print "#{decode_holes[n][0]} #{decode_holes[n][1]} #{decode_holes[n][2]} #{decode_holes[n][3]}\t\t"
      puts "#{key_holes[n][0]} #{key_holes[n][1]} #{key_holes[n][2]} #{key_holes[n][3]}\n"
    end
  end
end
