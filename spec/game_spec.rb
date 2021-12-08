#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

# Methods:
# initialize -> No test necessary here we are only creating instance variables
# play -> Public Script method No test needed but inside methods should be tested
# update_players_data -> Public Script method No test needed but inside methods should be tested
# update_player1_data -> Outgoing command should be tested
# update_player2_data -> Outgoing command should be tested
# verify_players_choices -> Looping method should be tested
# print_info -> No tests needed only print statements
# game_loop  -> Looping Script method Every method inside must be tested
# move_coordinates -> Looping method should be tested
# row_value -> Public Script method no test needed inside methods should be tested
# column_value -> Public Script method no test needed inside methods should be tested
# coordinate_input -> Looping method should be tested
# switch_players -> Command method should be tested
# announce_result -> No tests needed only print statements

describe Game do
  subject(:game) { described_class.new(player1, player2, board) }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:board) { instance_double(Board) }

  before do
    game.instance_variable_set(:@current_player, player1)
    game.instance_variable_set(:@other_player, player2)
  end

  describe '#update_player1_data' do
    before do
      allow(game).to receive(:puts)
      allow(player1).to receive(:update_data)
    end

    it 'sends message to update player 1 data' do
      expect(player1).to receive(:update_data).once
      game.update_player1_data
    end
  end

  describe '#update_player2_data' do
    before do
      allow(game).to receive(:puts)
      allow(player2).to receive(:update_data)
    end

    it 'sends message to update player 2 data' do
      expect(player2).to receive(:update_data).once
      game.update_player2_data
    end
  end

  describe '#verify_players_choices' do
    before do
      allow(player2).to receive(:update_choice)
    end

    context 'when player choices are same' do
      before do
        allow(player1).to receive(:choice).and_return('X', 'X')
        allow(player2).to receive(:choice).and_return('X', 'O')
      end

      it 'sends message to player2 to update the choice' do
        expect(player2).to receive(:update_choice).once
        game.verify_players_choices
      end
    end

    context 'when player choices are not same' do
      before do
        allow(player1).to receive(:choice).and_return('X')
        allow(player2).to receive(:choice).and_return('O')
      end

      it 'doesnt send message to player2 to update the choice' do
        expect(player2).not_to receive(:update_choice)
        game.verify_players_choices
      end
    end
  end

  describe '#move_coordinates' do
    before do
      allow(game).to receive(:row_value).and_return(1, 2)
      allow(game).to receive(:column_value).and_return(0, 2)
    end

    context 'when invalid coordinates given once, then valid coordinates' do
      before do
        allow(board).to receive(:valid_move?).and_return(false, true)
        allow(game).to receive(:print_input_error)
      end

      it 'completes execution after showing error message once' do
        expect(game).to receive(:print_input_error).once
        game.move_coordinates
      end

      it 'returns valid coordinates' do
        result = game.move_coordinates
        expect(result).to eq([2, 2])
      end
    end

    context 'when valid coordinates given' do
      before do
        allow(board).to receive(:valid_move?).and_return(true)
      end

      it 'completes execution without showing error message' do
        expect(game).not_to receive(:print_input_error)
        game.move_coordinates
      end

      it 'returns valid coordinates' do
        result = game.move_coordinates
        expect(result).to eq([1, 0])
      end
    end
  end

  describe '#coordinate_input' do
    before do
      allow(game).to receive(:print)
    end
    context 'when invalid input given once, then valid input' do
      before do
        allow(game).to receive(:gets).and_return('3', '1')
        allow(game).to receive(:print_input_error)
      end

      it 'completes execution after showing error message once' do
        expect(game).to receive(:print_input_error).once
        game.coordinate_input
      end

      it 'returns valid input' do
        result = game.coordinate_input
        expect(result).to eq(1)
      end
    end

    context 'when valid input given' do
      before do
        allow(game).to receive(:gets).and_return('1')
      end
      it 'completes execution without showing error message' do
        expect(game).not_to receive(:print_input_error)
        game.coordinate_input
      end

      it 'returns valid input' do
        result = game.coordinate_input
        expect(result).to eq(1)
      end
    end
  end

  describe '#switch_players' do
    it 'switches players' do
      previous = [game.current_player, game.other_player]
      game.switch_players
      result = [game.current_player, game.other_player]
      expect(result).to eq(previous.reverse)
    end
  end
end
