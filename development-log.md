# Development Log

# Status Update 1 - 4/9/19
The Cluedo App is now what I consider to be at MVP status. The user is able to start a new game with a default number of CPU "players". The game object will choose a card from each category for the "envelope" and then shuffle and distribute the remaining cards to the players. The user can make a guess in which they select a suspect, room and weapon, and if any of the CPU players possess any of the selected cards they will each show one of their cards to the user. The user can also choose to make their final accusation, which is compared to the cards in the envelope and the user will be informed if their guess is correct or not before the game ends.

Apart from the time it took to figure out how I would be storing game data in my objects, the only major issue has been the method for searching for a specific card in a player's hand, but the problem has since been fixed.

Today I intend to implement more functionality to improve user experience, including more sophisticated menuing and a checklist that will auto-update with every card the user sees.

# Status Update 2 - 5/9/19
As of yesterday I have implemented the vast majority of the intended features of the Cluedo app, more than was expected by this point. The menu and checklist features were implemented along with a feature that allows the user to save their game data to and load game data from an external JSON file. Some minor aesthetic improvements have also been made and the user can enter command line arguments to choose the player character and the number of players.

That said, the checklist and save/load features were significant roadblocks. Making changes to the formatted checklist didn't work as intended and my current solution (which involves creating a new tty-table object each time the checklist is rendered) is probably not the cleanest. Navigating the JSON format for the save file took some time as well and loading in the checklist proved difficult.

Today I intend to implement some minor features such as allowing the user to restart the game loop upon the game's completion, allowing the user to load their save through the command line, and potentially some more aesthetic additions.