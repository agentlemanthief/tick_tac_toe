# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Style/WordArray

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/gameboard'

describe GameBoard do
  subject(:game_board) { described_class.new }

  describe '#place_case' do
    it 'updates @board' do
      input = 'A1'
      updated_board = [
        ['X', ' ', ' '],
        [' ', ' ', ' '],
        [' ', ' ', ' ']
      ]
      game_board.place_case(input, 'X')
      expect(game_board.board).to eq(updated_board)
    end
  end

  describe '#validate?' do
    it 'returns true if input is correct format' do
      input = 'A1'
      expect(game_board.validate?(input)).to be true
    end

    it 'returns false for invalid input' do
      input = '11'
      expect(game_board.validate?(input)).to be_falsey
    end

    it 'returns false for input already used' do
      game_board.instance_variable_set(:@previous_choices, ['A1'])
      input = 'A1'
      expect(game_board.validate?(input)).to be_falsey
    end
  end

  describe '#win?' do
    it 'returns true if win_conditions met' do
      board_example = [
        ['X', ' ', ' '],
        [' ', 'X', ' '],
        [' ', ' ', 'X']
      ]
      game_board.instance_variable_set(:@board, board_example)
      expect(game_board.win?('X')).to be true
    end

    it 'does not return true if win_conditions not met' do
      board_example = [
        ['X', 'X', ' '],
        [' ', ' ', ' '],
        [' ', ' ', ' ']
      ]
      game_board.instance_variable_set(:@board, board_example)
      expect(game_board.win?('X')).to_not be true
    end
  end

  describe '#draw?' do
    it 'returns true if game is draw' do
      board_example = [
        ['X', 'X', 'O'],
        ['O', 'X', 'X'],
        ['X', 'O', 'O']
      ]
      game_board.instance_variable_set(:@board, board_example)
      expect(game_board.draw?).to be true
    end
  end

  describe '#clear_board' do
    it 'resets @board, @winner and @previous_choices' do
      board_example = [
        ['X', 'X', 'O'],
        ['O', 'X', 'X'],
        ['X', 'O', ' ']
      ]
      game_board.instance_variable_set(:@board, board_example)
      game_board.instance_variable_set(:@winner, 'X')
      game_board.instance_variable_set(:@previous_choices, ['A1'])
      board = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', ' ', ' ']
      ]
      game_board.clear_board
      previous_choices_test = game_board.instance_variable_get(:@previous_choices)
      expect(game_board.board).to eq(board)
      expect(game_board.winner).to eq('')
      expect(previous_choices_test).to eq([])
    end
  end
end
# rubocop:enable Metrics/BlockLength, Style/WordArray
