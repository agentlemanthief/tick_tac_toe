require_relative './game.rb'

def intro
  puts <<-Intro

  Welcolme to Tic-Tac_Toe!

  Tic-tac-toe, or noughts and crosses, is traditionally a paper-and-pencil game for two players,
  X and O, who take turns marking the spaces in a 3×3 grid.

  The player who succeeds in placing three of their marks in a diagonal, horizontal,
  or vertical row is the winner.

  You will be randomly assigned to X or O after entering your name.

  Good luck!

  Intro
end

intro
Game.new.play_game
