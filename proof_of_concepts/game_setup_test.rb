def present_game_options(game_details)
  puts "What kind of would you like to play?"
  str = ''
  game_details.each_with_index do |(key, value), index|
    str += "Enter #{index} for #{key} (#{value[:description]}). \n"
  end
  puts str
end

def get_game_type(game_details)
  key_index = gets.chomp.to_i
  key = game_details.keys[key_index]
  key
end

def get_name(player)
  puts "Please enter #{player} name:"
  name = gets.chomp
  name
end

def build_player_hash(game_details, game_type)
  players_index = game_details[game_type][:num_players] - 1
  player_types = game_details[game_type][:player_types]
  players = Hash.new
  
  0.upto(players_index).each do |i|
    player = "Player " + i.to_s
    players[player] = Hash.new
    player_type = player_types[i]
    players[player][:type] = player_type
    players[player][:score] = 0
    if player_type == "human"
      players[player][:name] = get_name(player)
    else
      players[player][:name] = "Computer " + i.to_s
    end
  end
  players
end

# Game details for our game
puts "Given a game detail hash this test shows that the code can present options and then set up the player hash."
game_details = {"1 Player" => {num_players: 2, description: "Play against the computer", player_types: ["human", "computer"]}, 
                "2 Player" => {num_players: 2, description: "Play against a friend", player_types: ["human", "human"]},
                "Simulation" => {num_players: 2, description: "Watch the computer play", player_types: ["computer", "computer"]}}


present_game_options(game_details)
game_type = get_game_type(game_details)
player_hash = build_player_hash(game_details, game_type)
puts "Player hash is filled with values we entered:"
puts player_hash

puts ""
puts ""

# Game details for an imagined game still works with same code
puts "The code is generic enough to handle any game options as long as a basic structure is followed."
game_details = {"3 Player" => {num_players: 3, description: "Three people playing against each other", player_types: ["human", "human", "human"]}, 
                "3 Computers" => {num_players: 3, description: "Three computer simulation", player_types: ["computer", "computer", "computer"]},
                "Joint with Computer" => {num_players: 4, description: "Two players playing jointly with computer", player_types: ["human", "computer", "human", "computer"]},
                "1 Player" => {num_players: 1, description: "Play alone", player_types: ["human"]},
                "10 Player" => {num_players: 10, description: "Large multiplayer mode", player_types: Array.new(10, "human")}}


present_game_options(game_details)
game_type = get_game_type(game_details)
player_hash = build_player_hash(game_details, game_type)
puts "Player hash is filled with values we entered:"
puts player_hash






