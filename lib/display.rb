#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './color'

# display stuff
module Display
  include Color

  def print_instructions
    puts <<~HEREDOC

      Rows => 0, 1, 2
      Columns => 0, 1, 2
      Enter respective Row and Column value to make a move.

      Let's Begin!

    HEREDOC
  end

  def print_introduction(player1, player2)
    puts <<~HEREDOC

      #{player1.name} => #{player1.choice}\t#{player2.name} => #{player2.choice}

    HEREDOC
  end

  def print_player_data(player)
    puts <<~HEREDOC

      #{player.name} '#{player.choice}':
    HEREDOC
  end

  def announce_draw
    puts <<~HEREDOC

      #{color_text('Oops! Draw!', :yellow)}

    HEREDOC
  end

  def announce_winner(player)
    puts <<~HEREDOC

      #{color_text("#{player.name} (#{player.choice}) Won!", :green)}

    HEREDOC
  end

  def print_input_error
    puts <<~HEREDOC

      #{color_text('Sorry, that is an invalid input. Please, try again.', :red)}

    HEREDOC
  end

  def line
    color_text(' +---+---+---+', :cyan).to_s
  end

  def pipe
    color_text(' | ', :cyan).to_s
  end

  def row1(board)
    "#{pipe}#{board[0][0]}#{pipe}#{board[0][1]}#{pipe}#{board[0][2]}#{pipe}"
  end

  def row2(board)
    "#{pipe}#{board[1][0]}#{pipe}#{board[1][1]}#{pipe}#{board[1][2]}#{pipe}"
  end

  def row3(board)
    "#{pipe}#{board[2][0]}#{pipe}#{board[2][1]}#{pipe}#{board[2][2]}#{pipe}"
  end
end
