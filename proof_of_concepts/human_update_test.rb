def build_answer_hash(possible_choices)
  answer_hash = Hash.new
  possible_choices.each do |item|
    letter = item[0]
    if !answer_hash.has_key?(letter)
      answer_hash[letter] = {:multiple => false, :items => [item]}
    else
      answer_hash[letter][:multiple] = true
      answer_hash[letter][:items] << item
    end
  end
  answer_hash 
end

def display_choices(item_array)
  puts "You entered a letter with multiple items:"
  
  str = ""
  item_array.each_with_index do |item, index|
    str += "Press #{index} for #{item}.\n"
  end
  puts str
end

def select_item(answer_hash)
  letter = ''
  loop do
    puts "Please enter a letter"
    letter = gets.chomp.downcase
    if answer_hash.has_key?(letter)
      break
    else
      puts "Sorry, that's an invalid choice. Try again..."
    end
  end
  
  multiple_items = answer_hash[letter][:multiple] 
  item_array = answer_hash[letter][:items]
  
  item = ''
  if multiple_items
    loop do
      display_choices(item_array)
      item_index = gets.chomp.to_i
      
      if valid_choice?(item_index, item_array.size - 1)
        item = item_array[item_index]
        break
      else
        puts "Sorry, invalid choice."
      end
    end
  else
    item = item_array.first
  end
  item
end

def valid_choice?(int, max_index)
  return true if int.between?(0, max_index)
  false    
end

def get_player_choices(players, answer_hash, possible_choices)
  player_answers = Hash.new
  players.each do |key, value|
    if value[:type] == 'computer'
      player_answers[key] = possible_choices.sample
    else
      player_answers[key] = select_item(answer_hash)
    end
  end
  player_answers
end

# Given a player hash and answer hash we can get user choices
puts "This code can take a list of players and possible choices, get an answer from the user, and fill out an array of answers for each player."
puts "This game has one human player and one computer player. The computer gets its answers automatically."
puts "Here is the player hash:"
puts players = {"Player 0"=>{:type=>"human", :name=>"James"}, "Player 1"=>{:type=>"computer", :name=>"Computer 1"}}
puts "Here are the possible choices:"
puts possible_choices = %w(rock lizard spock scissors paper papaya poop robot fots dork josh redneck purple xenta election extra whitehouse werner waitress)
answer_hash = build_answer_hash(possible_choices)
player_answers = get_player_choices(players, answer_hash, possible_choices)
puts "Here is the answer hash:"
puts player_answers

puts "\n \n"

# The same code works with different players and choices
puts "The same code can be used for any list of players and choice of items as long as some basic structural rules are followed."
puts "This game has two human players and two computer players. The computer gets its answers automatically."
puts "Here is the new player hash:"
puts players = {"Player 0"=>{:type=>"human", :name=>"James"}, 
           "Player 1"=>{:type=>"computer", :name=>"Computer 1"},
           "Player 2"=>{:type=>"human", :name=>"Brad"},
           "Player 3"=>{:type=>"computer", :name=>"Computer 2"}}
puts "Here are the new possible choices:"
puts possible_choices = %w(quit zebra bishop zeshawn x-ray boat alarm zeitgeist quilt barley quiet storage straw bank rabbit dummyhead vault octopus)
answer_hash = build_answer_hash(possible_choices)
player_answers = get_player_choices(players, answer_hash, possible_choices)
puts "Here is the answer hash:"
puts player_answers











