#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/board'

# Methods:
# initialize -> No test necessary here we are only creating instance variable
# update_cell -> Command method should be tested
# valid_move? -> Query method should be tested
# game_over? -> Query method should be tested
# win? -> Query method should be tested
# draw? -> Query method should be tested
# result -> Query method should be tested
# winning_positions -> Query method should be tested
# diagonals -> Private helper method will have test coverage in winning_positions
# print_board -> Only puts no need for testing

describe Board do
  describe '#initialize' do
    matcher :be_empty do
      match { |value| value == ' ' }
    end

    subject(:board) { described_class.new }

    it 'creates an empty board' do
      board_cells = board.board.flatten
      expect(board_cells).to all(be_empty)
    end
  end

  describe '#update_cell' do
    subject(:board) { described_class.new }

    it 'updates the value of the cell' do
      row = 0
      column = 2
      value = 'X'
      board.update_cell(row, column, value)
      expect(board.board[row][column]).to eq(value)
    end
  end

  describe '#valid_move?' do
    subject(:board) { described_class.new }
    context 'when the cell is empty' do
      it 'returns true' do
        row = 0
        column = 2
        result = board.valid_move?(row, column)
        expect(result).to be true
      end
    end

    context 'when the cell is not empty' do
      before do
        value = [
          [' ', ' ', 'X'],
          [' ', ' ', ' '],
          [' ', ' ', ' ']
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns false' do
        row = 0
        column = 2
        result = board.valid_move?(row, column)
        expect(result).to be false
      end
    end
  end

  describe '#game_over?' do
    subject(:board) { described_class.new }

    context 'when win occurs' do
      before { allow(board).to receive(:win?).and_return(true) }

      it 'returns true' do
        result = board.game_over?
        expect(result).to be true
      end
    end

    context 'when draw occurs' do
      before { allow(board).to receive(:draw?).and_return(true) }

      it 'returns true' do
        result = board.game_over?
        expect(result).to be true
      end
    end

    context 'when neither draw nor win occurs' do
      before do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(false)
      end

      it 'returns false' do
        result = board.game_over?
        expect(result).to be false
      end
    end
  end

  describe '#win?' do
    subject(:board) { described_class.new }

    context 'when winning position exist' do
      before do
        value = [
          [' ', ' ', 'X'],
          [' ', 'X', ' '],
          ['X', ' ', ' ']
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns true' do
        result = board.win?
        expect(result).to be true
      end
    end

    context 'when winning position not exist' do
      before do
        value = [
          [' ', ' ', 'X'],
          [' ', 'X', ' '],
          ['O', ' ', ' ']
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns false' do
        result = board.win?
        expect(result).to be false
      end
    end

    context 'when the board is empty' do
      before do
        value = [
          [' ', ' ', ' '],
          [' ', ' ', ' '],
          [' ', ' ', ' ']
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns false' do
        result = board.win?
        expect(result).to be false
      end
    end
  end

  describe '#draw?' do
    subject(:board) { described_class.new }

    context 'when the board is full' do
      before do
        value = [
          %w[X O X],
          %w[O X O],
          %w[O X O]
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns true' do
        result = board.draw?
        expect(result).to be true
      end
    end

    context 'when most of the board is full' do
      before do
        value = [
          ['O', ' ', 'X'],
          [' ', 'X', 'X'],
          ['O', 'O', ' ']
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns false' do
        result = board.draw?
        expect(result).to be false
      end
    end

    context 'when the board is empty' do
      before do
        value = [
          [' ', ' ', ' '],
          [' ', ' ', ' '],
          [' ', ' ', ' ']
        ]
        board.instance_variable_set(:@board, value)
      end

      it 'returns false' do
        result = board.draw?
        expect(result).to be false
      end
    end
  end

  describe '#result' do
    subject(:board) { described_class.new }

    context 'when win occurs' do
      before do
        allow(board).to receive(:win?).and_return(true)
      end

      it 'returns :win' do
        result = board.result
        expect(result).to eq(:win)
      end
    end

    context 'when draw occurs' do
      before do
        allow(board).to receive(:draw?).and_return(true)
      end

      it 'returns :draw' do
        result = board.result
        expect(result).to eq(:draw)
      end
    end

    context 'when neither win nor draw occurs' do
      before do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(false)
      end

      it 'returns nil' do
        result = board.result
        expect(result).to be_nil
      end
    end
  end

  describe '#winning_positions' do
    subject(:board) { described_class.new }

    before do
      value = [
        %w[X O O],
        %w[O X X],
        %w[X O O]
      ]
      board.instance_variable_set(:@board, value)
    end

    it 'returns winning positions' do
      value = board.board + board.board.transpose + [
        %w[X X O],
        %w[O X X]
      ]
      result = board.winning_positions
      expect(result).to eq(value)
    end
  end
end
