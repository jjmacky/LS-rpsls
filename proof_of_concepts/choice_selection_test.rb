possible_choices = %w(rock lizard spock scissors paper papaya poop robot fots dork josh redneck purple xenta election extra whitehouse werner waitress)

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
    letter = gets.chomp
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


puts "Possible choices are:"
puts possible_choices.join(", ")
puts ""

puts "The answer hash looks like this:"
answer_hash = build_answer_hash(possible_choices)
puts answer_hash
puts ""

puts "Here's how it works:"
puts select_item(answer_hash)