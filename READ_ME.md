

ABOUT THIS PROJECT  
The file play.rb allows the user to play one of three games:
1) Standard rock, paper, scissors
2) The Big Bang Theory version which adds lizard and Spock
3) A nine-item game of my own creation

The code that runs these games is the same, the only thing that differs are the configuration files.


CRAZY NINE-ITEM GAME  
To demonstrate that the same code could run different games I created a nine-item game with
a random set of objects which beat one another. The instructions are in nine_item_game.png.


PROJECT MOTIVATION  
I realized early on it would be easier to use a hash to lookup the winner rather than a bunch of
if statements. I created a 5x5 hash that can be thought of as a matrix where the row names are
the first player's choice and the column names are the second player's choice. Each cell is the
resulting winner.

Looking for an automated way to create this hash I noticed there were patterns in the win states.
This is shown in the answer_grid.png file in this folder. I realized that any game with the
star-shapped pattern of choices -- like the Big Bang version -- would be able to be generated 
automatically with the same code.


GENERIC FUNCTIONS  
Seeing that what I call the "win-state matrix" could be generated for different games using the
same code modivated me to try to make all of the mthods as generic and robust as possible.

The funtionality of the methods are shown in a set of files in the proof_of_concepts folder. There 
is some structure required of some of the input hashes, but other than that the code can read and 
output different inputs.

  Some examples:  
  * Given an arbitrary list of n words the code will build a hash that groups the words by the first 
  letter. If the user choses a letter with multipe words the words will automatically be presented 
  with cooresponding numbers so the user can chose between them.

  * Given a list of n players and their type -- either computer or human -- the code will collect a 
  list of player names and their initial score.

  * Given a win-state matrix of dimension n and the associated player answers the code can traverse 
  the hash to find the winner.

  * Given a game hash with directions the code can present game descriptions and setup the game.

  * Given a player hash the code can present the current score and list the winner.

As you can see many of the game functions are even more generic than the three provided games leverage.
For example, every game has to be able to periodically provide the score and present a winner, initiate
a game, etc. So this code is trying to inch toward a reusable game framework (although it is still very,
very, very far).


SIMULATION  
Because I wanted to make the code generic I thought that the computer should go through the same process
as the human player. So the computer is assigned a name and asked to provide an input. Having done that
I realized I could setup a simulation. Since each computer player knows how to select an answer and 
wait its turn, the computer can automatically play against itself.