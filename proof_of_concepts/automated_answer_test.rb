def get_letter(player_name, player_type, answer_hash)
  letter = ''
  loop do
    puts "#{player_name} please enter a letter..."
    if player_type == 'computer'
      sleep_time = 1.0 + Random.new.rand(1.0)
      sleep(sleep_time)
      puts letter = answer_hash.keys.sample
      break
    elsif player_type == 'human'
      letter = gets.chomp.downcase
      if answer_hash.has_key?(letter)
        break
      else
        puts "Sorry, that's an invalid choice. Try again..."
      end
    end 
  end
  letter
end


def resolve_multiple_choices(player_type, item_array, item)
  loop do
    display_choices(item_array)
    if player_type == 'computer'
      sleep_time = 1.0 + Random.new.rand(1.0)
      sleep(sleep_time)
      item_index = 0.upto(item_array.size - 1).to_a.sample
      puts item_index
      item = item_array[item_index]
      break
    elsif player_type == 'human'
      item_index = gets.chomp.to_i
      if valid_choice?(item_index, item_array.size - 1)
        item = item_array[item_index]
        break
      else
        puts "Sorry, invalid choice."
      end
    end
  end
  item
end

def select_item(player, answer_hash)
  player_name = player[:name]
  player_type = player[:type]
  letter = get_letter(player_name, player_type, answer_hash)
  
  sleep(0.3)
  
  multiple_items = answer_hash[letter][:multiple] 
  item_array = answer_hash[letter][:items]
  item = ''
  if multiple_items
    item = resolve_multiple_choices(player_type, item_array, item)
  else
    item = item_array.first
  end
  sleep(0.3)
  puts "You selected #{item}."
  item
end

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

def valid_choice?(int, max_index)
  return true if int.between?(0, max_index)
  false    
end

possible_choices = %w(rock lizard spock scissors paper papaya poop robot fots dork josh redneck purple xenta election extra whitehouse werner waitress)
answer_hash = build_answer_hash(possible_choices)
player = {:type=>"computer", :score => 0, :name=>"James"}
select_item(player, answer_hash)

