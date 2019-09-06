# Cluedo App - Help File
An app that lets you play Cluedo in your terminal.

## Installing
1. Install Ruby (works best in 2.5.5)

2. Clone this repository

```
git clone git@github.com:techspeterson/cluedo-app.git
```

3. Run the `build.sh` script in the command line:
```
bash build.sh
```
App files will be copied into `./dist` and all required gems will be automatically installed.

Gems used: `artii`, `colorize`, `tty-prompt`, `tty-table`

4. Navigate into `./dist` and run the main app file:
```
ruby app.rb
```

## Optional flags
Load game data:
```
ruby app.rb -l
```
Start a game as a specific character:
```
ruby app.rb -c plum
```
Start a game with a specific number of players:
```
ruby app.rb -p 5
```
## How to play
From the ingame menu, select **New game**, or **Load game** to load game data from `save-data.json` (if it exists).

Through the ingame menus, you can:

- **Guess the suspect, room and weapon** by selecting each component from the menu. If any of your opponents have a card you guessed, they'll show it to you.
- **View the checklist** of all the cards you've seen so far, to help narrow down your guesses.
- **Make your final accusation** when you're sure of the answer - if you get it right, you win! But if you get it wrong, it's game over!
- **Save your game** to an external file so you can resume later.