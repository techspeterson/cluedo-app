# Development Log

# Status Update 1 - 4/9/19
The Cluedo App is now what I consider to be at MVP status. The user is able to start a new game with a default number of CPU "players". The game object will choose a card from each category for the "envelope" and then shuffle and distribute the remaining cards to the players. The user can make a guess in which they select a suspect, room and weapon, and if any of the CPU players possess any of the selected cards they will each show one of their cards to the user. The user can also choose to make their final accusation, which is compared to the cards in the envelope and the user will be informed if their guess is correct or not before the game ends.

Apart from the time it took to figure out how I would be storing game data in my objects, the only major issue has been the method for searching for a specific card in a player's hand, but the problem has since been fixed.

Today I intend to implement more functionality to improve user experience, including more sophisticated menuing and a checklist that will auto-update with every card the user sees.