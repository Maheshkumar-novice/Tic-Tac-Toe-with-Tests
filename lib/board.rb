#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './display'

# Board Class
class Board
  include Display

  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
  end

  def update_cell(row, column, value)
    board[row][column] = value
  end

  def valid_move?(row, column)
    board[row][column] == ' '
  end

  def game_over?
    return true if win? || draw?

    false
  end

  def result
    return :win if win?
    return :draw if draw?
  end

  def win?
    winning_positions.each do |winning_position|
      next if winning_position.all?(' ')
      return true if winning_position.all? { |value| value == winning_position[0] }
    end
    false
  end

  def winning_positions
    board + board.transpose + diagonals
  end

  def diagonals
    [
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]]
    ]
  end

  def draw?
    board.flatten.none?(' ')
  end

  def print_board
    puts <<~HEREDOC

      Board:

      #{line}
      #{row1(board)}
      #{line}
      #{row2(board)}
      #{line}
      #{row3(board)}
      #{line}

    HEREDOC
  end
end
