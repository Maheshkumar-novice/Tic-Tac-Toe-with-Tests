#!/usr/bin/env ruby
# frozen_string_literal: true

# Player Class
class Player
  attr_reader :name, :choice

  def initialize
    @name = nil
    @choice = nil
  end

  def update_data
    @name = name_data
    @choice = choice_data
  end

  def name_data
    print 'Name > '
    name = gets.chomp.capitalize
    unless name.length.positive?
      puts 'Invalid Name!'
      return name_data
    end
    name
  end

  def choice_data
    print 'Choice (O | X) > '
    choice = gets.chomp.capitalize
    unless choice.match?(/^[OX]{1}$/)
      puts 'Invalid Choice!'
      return choice_data
    end
    choice
  end

  def update_choice
    puts 'Invalid Choice! Choice already taken!'
    @choice = choice_data
  end
end
