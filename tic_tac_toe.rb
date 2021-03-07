class GameBoard
  attr_reader :winner, :board
  attr_accessor :first, :second, :round
  def initialize()
    @board = [[' ', ' ', ' '],
              [' ', ' ', ' '],
              [' ', ' ', ' ']
    ]
    @winner = ''
    @previous_choices = []
    @round = 1
  end

  def print_board()
    puts "\n  1  2  3\na|#{@board[0][0]}  #{@board[0][1]}  #{@board[0][2]}\nb|#{@board[1][0]}  #{@board[1][1]}  #{@board[1][2]}\nc|#{@board[2][0]}  #{@board[2][1]}  #{@board[2][2]}\n"
  end

  def place_o_or_x(co_ord, o_or_x)
    while !co_ord.upcase.match(/^[A-C][1-3]$/) || @previous_choices.include?(co_ord.upcase)
      puts "Please ensure your input is in the following form: 'a1', and that this hasn't been used before.\nTry again..."
      co_ord = gets.chomp.upcase
    end
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
    print_board()
  end

  def play_round()
    while !(self.win?("O") || self.win?("X") || self.draw?)
      puts "#{first.name}, please choose where to place your #{first.o_or_x}"
      self.place_o_or_x(gets.chomp, first.o_or_x)
      if self.win?("O") || self.win?("X") || self.draw?
        break
      end
      puts "#{second.name}, please choose where to place your #{second.o_or_x}"
      self.place_o_or_x(gets.chomp, second.o_or_x)
    end
  end

  def win?(o_or_x)
    if @board[0][0] == o_or_x && @board[0][1] == o_or_x && @board[0][2] == o_or_x || @board[1][0] == o_or_x && @board[1][1] == o_or_x && @board[1][2] == o_or_x || @board[2][0] == o_or_x && @board[2][1] == o_or_x && @board[2][2] == o_or_x || @board[0][0] == o_or_x && @board[1][0] == o_or_x && @board[2][0] == o_or_x || @board[0][1] == o_or_x && @board[1][1] == o_or_x && @board[2][1] == o_or_x || @board[0][2] == o_or_x && @board[1][2] == o_or_x && @board[2][2] == o_or_x || @board[0][0] == o_or_x && @board[1][1] == o_or_x && @board[2][2] == o_or_x || @board[2][0] == o_or_x && @board[1][1] == o_or_x && @board[0][2] == o_or_x
      @winner = o_or_x
      true
    end
  end

  def draw?()
    unless @board.flatten.include?(' ')
      true
    end
  end

  def clear_board()
    @board = [[' ', ' ', ' '],
              [' ', ' ', ' '],
              [' ', ' ', ' ']
    ]
    @winner = ''
    @previous_choices = []
  end
end

class Player
  attr_reader :name, :o_or_x
  attr_accessor :score
  @@player_number = 1
  @@previous_o_or_x = ''
  def initialize()
    @name = get_player_name()
    @o_or_x = get_o_or_x()
    @score = 0
    @@player_number += 1
  end

  def get_player_name()
    puts "Player #{@@player_number}, Please enter a name:"
    choice = gets.chomp.capitalize
  end

  def get_o_or_x()
    if @@previous_o_or_x == 'X'
      puts "You are O's you go second"
      'O'
    elsif @@previous_o_or_x == 'O'
      puts "You are X's, you go first"
      'X'
    else
      if rand(2) == 0
        @o_or_x = 'X'
        puts "You are X's, you go first\n"
      else
        @o_or_x = 'O'
        puts "You are O's, you go second\n"
      end
      @@previous_o_or_x = @o_or_x
    end
  end

  def name_by_o_or_x(o_or_x)
    if @o_or_x == o_or_x
      @name
    end
  end

  def self.clear_previous_o_or_x()
    @@previous_o_or_x = ''
  end
end

game_board = GameBoard.new()

player_one = Player.new()

player_two = Player.new()

puts "This is the game board."
sleep(0.5)

game_board.print_board

puts "When prompted please type a co-ordinate to place your mark."
sleep(0.5)
puts "The first player to get a line of THREE of their marks wins the round."
sleep(0.5)
puts "The first player to win THREE rounds wins the game!"


3.times do
  game_board.clear_board

  puts "Round #{game_board.round}"

  game_board.print_board

  game_board.round += 1

  if player_one.o_or_x == 'X'
    game_board.first = player_one
    game_board.second = player_two
  else
    game_board.first = player_two
    game_board.second = player_one
  end

  game_board.play_round

  if game_board.draw?
    puts "The round is a draw!"
  else
    winner = game_board.first.name_by_o_or_x(game_board.winner) || game_board.second.name_by_o_or_x(game_board.winner)

    if player_one.o_or_x == game_board.winner
      player_one.score += 1
    else
      player_two.score += 1
    end

    puts "The winner of this round is #{winner}"
    sleep(0.5)
    unless game_board.round > 3
      puts "\n\nNext round in... "
      puts "3... "
      sleep(1)
      puts "2... "
      sleep(1)
      puts "1...\n\n"
      sleep(1.5)
    end
  end
end

if player_one.score > player_two.score
  puts "\nThe winner of the game is #{player_one.name}\nCongratulations!!!"
elsif player_one.score < player_two.score
  puts "\nThe winner of the game is #{player_two.name}\nCongratulations!!!"
else
  puts "\nThe game is a draw!!\nYou both win!!!"
end

sleep(2)
