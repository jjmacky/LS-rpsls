def prompt(message, prepend_empty_line = false)
  prefix = ""
  prefix = "\n" if prepend_empty_line
  new_message = (prefix+message).split("\n").map(&:strip).map do |str|
    "=> #{str}"
  end
  puts new_message.join(" \n")
end

def reterive_message(message)
  GAME_MESSAGES[message]
end

def display_game_options 
  prompt(reterive_message('game_choice'), true)
  str = ''
  GAME_DETAILS.each_with_index do |(key, value), index|
    str += "Enter #{index} for #{key} (#{value[:description]}). \n"
  end
  prompt(str)
end

def game_option
  key = -1
  loop do
    key_index = gets.chomp
    if valid_choice?(key_index, GAME_DETAILS.keys.size - 1)
      key = GAME_DETAILS.keys[key_index.to_i]
      break
    else
      prompt(reterive_message('invalid_choice'))
    end
  end
  key
end

def build_player_list(game_type)
  players_index = GAME_DETAILS[game_type][:num_players] - 1
  player_types = GAME_DETAILS[game_type][:player_types]
  players = Hash.new
  0.upto(players_index).each do |player_index|
    initalize_player(players, player_index, player_types[player_index])
  end
  players
end

def initalize_player(players, player_index, player_type)
  player = "Player " + player_index.to_s
  players[player] = Hash.new
  players[player][:type] = player_type
  players[player][:score] = INITIAL_SCORE
  players[player][:name] = if player_type == "human"
                             get_name(player)
                           else
                             "Computer " + player_index.to_s
                           end
end

def build_win_state_matrix
  max_index = ITEM_LIST.size - 1
  win_state_matrix = Hash.new
  ITEM_LIST.each_with_index do |key, i|
    value = Hash[(0..max_index).map do |j|
                   [ITEM_LIST[j], WIN_STATES.rotate(-i)[j]]
                 end]
    win_state_matrix[key] = value
  end
  win_state_matrix
end

def build_choices
  choices = Hash.new
  ITEM_LIST.each do |item|
    letter = item[0]
    if !choices.key?(letter)
      choices[letter] = { multiple: false, items: [item] }
    else
      choices[letter][:multiple] = true
      choices[letter][:items] << item
    end
  end
  choices
end

def get_name(player)
  prompt("Please enter #{player} name:")
  name = gets.chomp
  name
end

def select_item(player, choices)
  player_name = player[:name]
  player_type = player[:type]
  letter = get_letter(player_name, player_type, choices)
  sleep(PAUSE_TIME)
  multiple_items = choices[letter][:multiple]
  item_array = choices[letter][:items]
  item = if multiple_items
           resolve_multiple_choices(player_type, item_array, item)
         else
           item_array.first
         end
  sleep(PAUSE_TIME)
  prompt("You selected #{item}.")
  item
end

def get_letter(player_name, player_type, choices)
  letter = ''
  loop do
    prompt("#{player_name} please enter a letter...")
    if player_type == 'computer'
      puts letter = get_computer_letter(choices)
      break
    elsif player_type == 'human'
      letter = get_human_letter(choices)
      break unless letter.nil?
    end
  end
  letter
end

def get_computer_letter(choices)
  sleep(THINKING_TIME)
  choices.keys.sample
end

def get_human_letter(choices)
  letter = gets.chomp.downcase
  if choices.key?(letter)
    return letter
  else
    prompt(reterive_message('invalid_choice'))
  end
end

def resolve_multiple_choices(player_type, item_array, item)
  loop do
    display_choices(item_array)
    if player_type == 'computer'
      item = get_computer_choice(item_array)
      break
    else
      item = get_human_choice(item_array)
      break unless item.nil?
    end
  end
  item
end

def get_computer_choice(item_array)
  sleep(THINKING_TIME)
  item_index = 0.upto(item_array.size - 1).to_a.sample
  puts item_index
  item_array[item_index]
end

def get_human_choice(item_array)
  item_index = gets.chomp
  if valid_choice?(item_index, item_array.size - 1)
    item = item_array[item_index.to_i]
  else
    prompt(reterive_message('invalid_choice'))
  end
  item
end

def display_choices(item_array)
  prompt(reterive_message('multiple_items'))
  str = ""
  item_array.each_with_index do |item, index|
    str += "Press #{index} for #{item}.\n"
  end
  prompt(str)
end

def get_player_responses(players, choices)
  player_answers = Hash.new
  players.each do |key, value|
    player_answers[key] = select_item(value, choices)
  end
  player_answers
end

def valid_choice?(int, max_index)
  if integer?(int)
    return true if valid_range(int.to_i, max_index)
  end
  false
end

def valid_range(int, max_index)
  int.between?(0, max_index)
end

def integer?(num)
  num.to_i.to_s == num
end

def get_game_winner(win_state_matrix, player_responses)
  temp = win_state_matrix
  player_responses.each_value do |value|
    temp = temp[value]
  end
  temp
end

def update_score(players, winner)
  players.each do |key, value|
    value[:score] += 1 if key == winner
  end
end

def display_game_winner(players, winner)
  if winner == "Tie"
    prompt(reterive_message('tie'), true)
  else
    name = players[winner][:name]
    prompt("#{name} is the winner!", true)
  end
end

def display_score(players)
  str = ''
  prompt("Here is the score:")
  players.each_value do |value|
    name = value[:name]
    score = value[:score]
    str += "#{name}: #{score} \n"
  end
  prompt(str)
end

def get_match_winner(players)
  players.each_value do |value|
    return value[:name] if value[:score] >= SCORE_THAT_WINS
  end
  false
end

def display_game_choices
  str = ''
  keys = GAME_CHOICES.keys
  keys.each_with_index do |key, index|
    description = GAME_CHOICES[key][:description]
    str += "Press #{index} for #{description}. \n"
  end
  prompt(str)
end

def choose_game
  file = ''
  loop do
    prompt("Please enter a game choice.")
    game_index = gets.chomp
    if valid_choice?(game_index, GAME_CHOICES.keys.size - 1)
      key = GAME_CHOICES.keys[game_index.to_i]
      file = GAME_CHOICES[key][:file]
      break
    else
      prompt(reterive_message('invalid_choice'))
    end
  end
  file
end

def display_game_directions
  prompt(GAME_DIRECTIONS, true)
end

def display_game_goal
  prompt("We'll play to #{SCORE_THAT_WINS}.")
end

def display_game_items
    prompt("Here are the choices: #{ITEM_LIST.join(', ')}.")
end

def display_another_game_message
  prompt(reterive_message('another_game'), true)
end

def display_match_winner_message(match_winner)
  prompt("\n#{match_winner} won the match!")
end

def exit_game?
  answer = ''
  loop do
    prompt(reterive_message('play_again'))
    answer = gets.chomp.downcase
    if answer == 'yes'
      return false
    elsif answer == 'no'
      return true
    else
      prompt(reterive_message('invalid_choice'))
    end
  end 
end

# Get config options
require 'yaml'
GAME_CHOICES = YAML.load_file('main_config.yml')
GAME_MESSAGES = YAML.load_file('messages.yml')
display_game_choices
file = choose_game
CONFIG = YAML.load_file(file)

GAME_DETAILS = CONFIG['game_details'][:Options]
GAME_DIRECTIONS = CONFIG['game_details'][:Directions]
WIN_STATES = CONFIG['win_states']
ITEM_LIST = CONFIG['item_list']
SCORE_THAT_WINS = CONFIG['score_that_wins']
INITIAL_SCORE = CONFIG['initial_score']
THINKING_TIME = CONFIG['thinking_time']
PAUSE_TIME = CONFIG['pause_time']

loop do
  # Set up game
  display_game_directions
  display_game_goal
  display_game_items
  display_game_options
  players = build_player_list(game_option())
  win_state_matrix = build_win_state_matrix
  choices = build_choices

  # Play game
  match_winner = false
  until match_winner
    player_responses = get_player_responses(players, choices)
    winner = get_game_winner(win_state_matrix, player_responses)
    display_game_winner(players, winner)
    update_score(players, winner)
    display_score(players)
    match_winner = get_match_winner(players)
    display_another_game_message unless match_winner
    display_game_items unless match_winner
  end
  display_match_winner_message(match_winner)
  break if exit_game?
end
