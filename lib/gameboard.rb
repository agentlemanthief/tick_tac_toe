# Frozen_string_literal: true

# Creates new GameBoard class for storing gamestate
class GameBoard
  attr_reader :winner, :board
  attr_accessor :first, :second, :round

  def initialize
    @board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
    @winner = ''
    @previous_choices = []
    @round = 1
  end

  def print_board
    puts <<-BOARD

         1   2   3
      a| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |
      b| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |
      c| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |

    BOARD
  end

  def place_o_or_x(co_ord, o_or_x)
    until validate?(co_ord)
      # rubocop:disable Layout/LineLength
      puts "Please ensure your input is in the following form: 'a1', and that this hasn't been used before.\nTry again..."
      # rubocop:enable Layout/LineLength
      co_ord = gets.chomp.upcase!
    end
    place_case(co_ord, o_or_x)
    print_board
  end

  def validate?(co_ord)
    co_ord.to_s.match(/^[A-C][1-3]$/) && !@previous_choices.include?(co_ord)
  end

  def place_case(co_ord, o_or_x)
    case co_ord
    when 'A1'
      @board[0][0] = o_or_x
      @previous_choices.push('A1')
    when 'A2'
      @board[0][1] = o_or_x
      @previous_choices.push('A2')
    when 'A3'
      @board[0][2] = o_or_x
      @previous_choices.push('A3')
    when 'B1'
      @board[1][0] = o_or_x
      @previous_choices.push('B1')
    when 'B2'
      @board[1][1] = o_or_x
      @previous_choices.push('B2')
    when 'B3'
      @board[1][2] = o_or_x
      @previous_choices.push('B3')
    when 'C1'
      @board[2][0] = o_or_x
      @previous_choices.push('C1')
    when 'C2'
      @board[2][1] = o_or_x
      @previous_choices.push('C2')
    when 'C3'
      @board[2][2] = o_or_x
      @previous_choices.push('C3')
    end
  end

  def play_round
    until win?('O') || win?('X') || draw?
      puts "#{first.name}, please choose where to place your #{first.o_or_x}"
      place_o_or_x(gets.chomp.upcase!, first.o_or_x)
      return if win?('O') || win?('X') || draw?

      puts "#{second.name}, please choose where to place your #{second.o_or_x}"
      place_o_or_x(gets.chomp.upcase!, second.o_or_x)
    end
  end

  def win?(o_or_x)
    return unless win_conditions(o_or_x)

    @winner = o_or_x
    true
  end

  def win_conditions(o_or_x)
    # rubocop:disable Layout/LineLength
    @board[0][0] == o_or_x && @board[0][1] == o_or_x && @board[0][2] == o_or_x || @board[1][0] == o_or_x && @board[1][1] == o_or_x && @board[1][2] == o_or_x || @board[2][0] == o_or_x && @board[2][1] == o_or_x && @board[2][2] == o_or_x || @board[0][0] == o_or_x && @board[1][0] == o_or_x && @board[2][0] == o_or_x || @board[0][1] == o_or_x && @board[1][1] == o_or_x && @board[2][1] == o_or_x || @board[0][2] == o_or_x && @board[1][2] == o_or_x && @board[2][2] == o_or_x || @board[0][0] == o_or_x && @board[1][1] == o_or_x && @board[2][2] == o_or_x || @board[2][0] == o_or_x && @board[1][1] == o_or_x && @board[0][2] == o_or_x
    # rubocop:enable Layout/LineLength
  end

  def draw?
    return if @board.flatten.include?(' ')
    true
  end

  def clear_board
    @board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
    @winner = ''
    @previous_choices = []
  end
end
