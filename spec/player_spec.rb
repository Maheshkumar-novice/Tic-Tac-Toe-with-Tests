#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/player'

# Methods:
# initialize -> No test necessary here we are only creating instance variable
# update_data -> Script method no test necessary
# name_data -> Looping method needs to be tested
# choice_data -> Looping method needs to be tested
# update_choice -> Script method no test necessary

describe Player do
  subject(:player) { described_class.new }

  describe '#name_data' do
    before do
      allow(player).to receive(:print)
    end

    context 'when invalid input given once, then valid input' do
      before do
        allow(player).to receive(:gets).and_return('', 'hello')
        allow(player).to receive(:puts)
      end

      it 'completes execution after showing error message once' do
        expect(player).to receive(:puts).with('Invalid Name!').once
        player.name_data
      end

      it 'returns valid name' do
        name = player.name_data
        expect(name).to  eq('hello')
      end
    end

    context 'when valid input given' do
      before do
        allow(player).to receive(:gets).and_return('hello')
      end

      it 'completes execution without showing error message' do
        expect(player).not_to receive(:puts).with('Invalid Name!')
        player.name_data
      end

      it 'returns valid name' do
        name = player.name_data
        expect(name).to  eq('hello')
      end
    end
  end

  describe '#choice_data' do
    before do
      allow(player).to receive(:print)
    end

    context 'when invalid input given once, then valid input' do
      before do
        allow(player).to receive(:gets).and_return('hello', 'O')
        allow(player).to receive(:puts)
      end

      it 'completes execution after showing error message once' do
        expect(player).to receive(:puts).with('Invalid Choice!').once
        player.choice_data
      end

      it 'returns valid name' do
        choice = player.choice_data
        expect(choice).to eq('O')
      end
    end

    context 'when valid input given' do
      before do
        allow(player).to receive(:gets).and_return('O')
      end

      it 'completes execution without showing error message' do
        expect(player).not_to receive(:puts).with('Invalid Choice!')
        player.choice_data
      end

      it 'returns valid name' do
        choice = player.choice_data
        expect(choice).to eq('O')
      end
    end
  end
end
