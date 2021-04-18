# Frozen_string_literal: true

require_relative 'player'
require_relative 'gameboard'

# Class defines game and gameplay flow
class Game
  def initialize
    @game_board = GameBoard.new
    @player_one = Player.new
    @player_two = Player.new
  end

  def play_game
    intro
    3.times do
      game_setup
      round_winner_declare
    end
    game_winner_declare
  end

  private
  def round_winner_declare
    if @game_board.winner
      winner = assign_winner
      round_winner_text(winner)
    else
      puts 'The round is a draw!'
    end
  end

  def assign_winner
    winner = @game_board.first.name_by_o_or_x(@game_board.winner) ||
    @game_board.second.name_by_o_or_x(@game_board.winner)
    if @player_one.o_or_x == @game_board.winner
      @player_one.score += 1
    else
      @player_two.score += 1
    end
    winner
  end

  def round_winner_text(winner)
    puts "The winner of this round is #{winner}"
    sleep(0.5)
    return if @game_board.round > 3

    puts "\n\nNext round in... "
    puts '3... '
    sleep(1)
    puts '2... '
    sleep(1)
    puts "1...\n\n"
    sleep(1.5)
  end

  def game_winner_declare
    if @player_one.score > @player_two.score
      puts "\nThe winner of the game is #{@player_one.name}\nCongratulations!!!"
    elsif @player_one.score < @player_two.score
      puts "\nThe winner of the game is #{@player_two.name}\nCongratulations!!!"
    else
      puts "\nThe game is a draw!!\nYou both win!!!"
    end
    sleep(2)
  end

  def game_setup
    @game_board.clear_board
    puts "Round #{@game_board.round}"
    @game_board.print_board
    @game_board.round += 1
    assign_players
    @game_board.play_round
  end

  def assign_players
    if @player_one.o_or_x == 'X'
      @game_board.first = @player_one
      @game_board.second = @player_two
    else
      @game_board.first = @player_two
      @game_board.second = @player_one
    end
  end

  def intro
    puts 'When prompted please type a co-ordinate to place your mark.'
    sleep(0.5)
    puts 'The first player to get a line of THREE of their marks wins the round.'
    sleep(0.5)
    puts 'The first player to win THREE rounds wins the game!'
  end
end
