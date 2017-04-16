

# This method lets us traverse all the way down a hash given a list of player responses
def get_game_result(win_state_matrix, player_answers)
  temp = win_state_matrix
  player_answers.each_value do |value|
    temp = temp[value]
  end
  temp
end

puts "This test shows we can traverse all the way down a win-state hash given a list of player responses."

puts "The hash can be very deep like this:"
puts win_state_matrix = {"answer 1" => {"answer 2" => {"answer 3" => {"answer 4" => "Winner is Player X." }}}}
puts "With these player answers:"
puts player_answers = {"player 1" => "answer 1", "player 2" => "answer 2", "player 3" => "answer 3", "player 4" => "answer 4"}
puts "And still get the result:"
puts get_game_result(win_state_matrix, player_answers)

puts "\n \n"

puts "Or only one level deep:"
puts win_state_matrix = {"answer 1" => "Winner is Player 1."}
puts player_answers = {"player 1" => "answer 1"}
puts get_game_result(win_state_matrix, player_answers)
