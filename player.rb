# Creates a new player object
class Player
  attr_reader :name, :o_or_x
  attr_accessor :score

  @@player_number = 1
  @@previous_o_or_x = ''
  def initialize
    @name = assign_player_name
    @o_or_x = assign_o_or_x
    @score = 0
    @@player_number += 1
  end

  def assign_player_name
    puts "Player #{@@player_number}, Please enter a name:"
    gets.chomp.capitalize
  end

  def assign_o_or_x
    case @@previous_o_or_x
    when 'X'
      puts "You are O's you go second"
      'O'
    when 'O'
      puts "You are X's, you go first"
      'X'
    else
      if rand(2).zero?
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
    return @name if @o_or_x == o_or_x
  end

  def self.clear_previous_o_or_x
    @@previous_o_or_x = ''
  end
end
