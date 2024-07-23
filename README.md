**Mastermind**
The second object oriented project. It's a guessing game played by two players, one as the code maker and one as the code guesser. The goal for the code maker is to give the code maker as little hints as possible, while the code guesser tries their best to guess the right set of code combination under a predetermined number of turns.

The set up of this game is a board with rows and holes. There are 12 rows, representing the turn of the code guesser, and 4 huge holes, where the colored pegs belong for guesses, and 4 small holes, where the colored pegs belong for feedbacks.

Before we start the game, the code maker has to secretly place the colored pegs, in any order, in the row of holes for the code maker only. The code maker has the option to put more than one peg of the same color.

The huge holes are where the code guesser places the pegs, in attempt to mimic the same code combination made by the code maker. The code maker then places *feedback* pegs for the small holes, only represented as red and white. Red peg indicates that the code guesser has correctly placed the peg in the right order, and with the same color. On the other hand, white peg only indicates that the guesser has placed the correct color of the peg, but in the wrong order. The catch is that the code maker can put these pegs in any order too but not necessarily indicating a pattern. This adds an extra challenger for the guesser.

As mentioned, there are 12 rows, which means the code guesser only has 12 attempts to guess the code. If the guesser runs out of turns, the code maker wins. Otherwise, the guesser wins if they guessed under 12 turns.

PS: No undo method yet. I'm tired of this project i wanna move on