require_relative './player.rb'
require_relative './gameboard.rb'

# Class defines game and gameplay flow
class Game
  def initialize
    @game_board = GameBoard.new
    @player_one = Player.new
    @player_two = Player.new
  end

  def intro
    puts 'This is the game board.'
    sleep(0.5)

    @game_board.print_board

    puts 'When prompted please type a co-ordinate to place your mark.'
    sleep(0.5)
    puts 'The first player to get a line of THREE of their marks wins the round.'
    sleep(0.5)
    puts 'The first player to win THREE rounds wins the game!'
  end

  def game_setup
    @game_board.clear_board

    puts "Round #{@game_board.round}"

    @game_board.print_board

    @game_board.round += 1

    if @player_one.o_or_x == 'X'
      @game_board.first = @player_one
      @game_board.second = @player_two
    else
      @game_board.first = @player_two
      @game_board.second = @player_one
    end

    @game_board.play_round
  end

  def play_game
    intro

    3.times do
      game_setup

      if @game_board.draw?
        puts 'The round is a draw!'
      else
        winner = @game_board.first.name_by_o_or_x(@game_board.winner) ||
                 @game_board.second.name_by_o_or_x(@game_board.winner)

        if @player_one.o_or_x == @game_board.winner
          @player_one.score += 1
        else
          @player_two.score += 1
        end

        puts "The winner of this round is #{winner}"
        sleep(0.5)
        unless @game_board.round > 3
          puts "\n\nNext round in... "
          puts '3... '
          sleep(1)
          puts '2... '
          sleep(1)
          puts "1...\n\n"
          sleep(1.5)
        end
      end
    end

    if @player_one.score > @player_two.score
      puts "\nThe winner of the game is #{@player_one.name}\nCongratulations!!!"
    elsif @player_one.score < @player_two.score
      puts "\nThe winner of the game is #{@player_two.name}\nCongratulations!!!"
    else
      puts "\nThe game is a draw!!\nYou both win!!!"
    end

    sleep(2)
  end
end
