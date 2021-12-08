#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './display'
require_relative './player'
require_relative './board'

# Game Class
class Game
  include Display

  attr_reader :current_player, :other_player, :board

  def initialize(player1 = Player.new, player2 = Player.new, board = Board.new)
    @board = board
    @current_player, @other_player = [player1, player2].shuffle
  end

  def play
    update_players_data
    print_info
    game_loop
    announce_result
  end

  def update_players_data
    update_player1_data
    update_player2_data
    verify_players_choices
  end

  def update_player1_data
    puts 'Enter Player 1 Data: '
    @current_player.update_data
  end

  def update_player2_data
    puts 'Enter Player 2 Data: '
    @other_player.update_data
  end

  def verify_players_choices
    @other_player.update_choice until @other_player.choice != @current_player.choice
  end

  def print_info
    board.print_board
    print_instructions
    print_introduction(current_player, other_player)
  end

  def game_loop
    loop do
      print_player_data(current_player)
      row, column = move_coordinates
      board.update_cell(row, column, current_player.choice)
      board.print_board
      break if board.game_over?

      switch_players
    end
  end

  def move_coordinates
    row = row_value
    column = column_value
    until board.valid_move?(row, column)
      print_input_error
      row = row_value
      column = column_value
    end
    [row, column]
  end

  def row_value
    print 'Enter Row '
    coordinate_input
  end

  def column_value
    print 'Enter Column '
    coordinate_input
  end

  def coordinate_input
    print '> '
    input = gets.chomp
    unless input.match?(/^[0-2]{1}$/)
      print_input_error
      return coordinate_input
    end
    input.to_i
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def announce_result
    if board.result == :win
      announce_winner(current_player)
      return
    end
    announce_draw
  end
end
