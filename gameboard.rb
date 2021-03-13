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
    puts "\n  1  2  3\na|#{@board[0][0]}  #{@board[0][1]}  #{@board[0][2]}\nb|#{@board[1][0]}  #{@board[1][1]}  #{@board[1][2]}\nc|#{@board[2][0]}  #{@board[2][1]}  #{@board[2][2]}\n\n"
  end

  def place_o_or_x(co_ord, o_or_x)
    while !co_ord.upcase.match(/^[A-C][1-3]$/) || @previous_choices.include?(co_ord.upcase)
      puts "Please ensure your input is in the following form: 'a1', and that this hasn't been used before.\nTry again..."
      co_ord = gets.chomp.upcase
    end
    place_case(co_ord, o_or_x)
    print_board
  end

  def place_case(co_ord, o_or_x)
    if !!co_ord.upcase.match(/^[A-C][1-3]$/)
      case co_ord.upcase
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
  end

  def play_round
    while !(win?('O') || win?('X') || draw?)
      puts "#{first.name}, please choose where to place your #{first.o_or_x}"
      place_o_or_x(gets.chomp, first.o_or_x)
      if win?('O') || win?('X') || draw?
        break
      end

      puts "#{second.name}, please choose where to place your #{second.o_or_x}"
      place_o_or_x(gets.chomp, second.o_or_x)
    end
  end

  def win?(o_or_x)
    if @board[0][0] == o_or_x && @board[0][1] == o_or_x && @board[0][2] == o_or_x || @board[1][0] == o_or_x && @board[1][1] == o_or_x && @board[1][2] == o_or_x || @board[2][0] == o_or_x && @board[2][1] == o_or_x && @board[2][2] == o_or_x || @board[0][0] == o_or_x && @board[1][0] == o_or_x && @board[2][0] == o_or_x || @board[0][1] == o_or_x && @board[1][1] == o_or_x && @board[2][1] == o_or_x || @board[0][2] == o_or_x && @board[1][2] == o_or_x && @board[2][2] == o_or_x || @board[0][0] == o_or_x && @board[1][1] == o_or_x && @board[2][2] == o_or_x || @board[2][0] == o_or_x && @board[1][1] == o_or_x && @board[0][2] == o_or_x
      @winner = o_or_x
      true
    end
  end

  def draw?
    return if @board.flatten.include?(' ')
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
