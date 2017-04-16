
require 'yaml'
CONFIG = YAML.load_file('test_config.yml')

puts CONFIG['game_details'][:Directions]
puts CONFIG['game_details'][:Options]
puts ""
puts CONFIG['win_states']