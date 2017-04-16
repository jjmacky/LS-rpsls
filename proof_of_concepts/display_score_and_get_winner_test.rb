def prompt(message)
  new_message = message.split("\n").map(&:strip).map do |str|
    "=> #{str}"
  end
  puts new_message.join(" \n")
end

def update_score(players, winner)
  players.each do |key, value|
    value[:score] += 1 if key == winner
  end
end

def display_score(players)
  str = ''
  prompt("Here is the score:")
  players.each do |key, value|
    name, score = value[:name], value[:score]
    str += "#{name}: #{score} \n"
  end
  prompt(str)
end

def get_game_winner(players, score_that_wins)
  players.each_value do |value|
    return value[:name] if value[:score] >= score_that_wins
  end
  false
end


# Print results
players = {"Player 0"=>{:type=>"human", :name=>"James", :score=>0}, "Player 1"=>{:type=>"computer", :name=>"Computer 1", :score=>0}}
score_that_wins = 5

puts "Here are the players:"
puts players

puts "Is there a winner yet?"
puts get_game_winner(players, score_that_wins)

puts "Let's play 5 rounds where Player 0 wins:"
winner = "Player 0"
5.times do
  update_score(players, winner)
end
display_score(players)

puts "\n"
puts "Is there a winner?"
puts get_game_winner(players, score_that_wins)

puts "\n \n"

puts "Our same code works for any list of players and final score requirement"
players = {"Player 0"=>{:type=>"human", :name=>"James", :score=>0}, 
           "Player 1"=>{:type=>"computer", :name=>"Computer 1", :score=>0},
           "Player 2"=>{:type=>"human", :name=>"Brad", :score=>0}, 
           "Player 3"=>{:type=>"human", :name=>"Steve", :score=>0}, 
           "Player 4"=>{:type=>"computer", :name=>"Computer 2", :score=>0}}
score_that_wins = 8

puts "Here is our new player list:"
puts players

puts "\n"

puts "Is there a winner yet?"
puts get_game_winner(players, score_that_wins)

puts "Let's play to 8."
winner = false
until winner do
  key = players.keys.sample
  players[key][:score] += 1
  winner = get_game_winner(players, score_that_wins)
end
display_score(players)
puts "Who is the winner?"
winner = get_game_winner(players, score_that_wins)
puts winner