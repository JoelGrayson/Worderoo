#  Plan

* Game - the game. Controls the guess, attempts, and answer
    * Code - a list of characters. It has various kinds (guess, attempt)
        * Character - a single character which has a color to indicate its status
            * Enum status (.nothing (not guessed yet), .correct (will show green), .wrongPlace (will show yellow), and .blank (will show dark gray))

