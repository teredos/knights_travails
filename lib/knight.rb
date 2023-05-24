# frozen_string_literal: true

# Creates a class for a Knight, keeping track of the Knight's position, previous
# move (parent) and next available moves
class Knight
  attr_accessor :pos, :next_moves, :parent

  DIRECTIONS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1],
                [2, -1], [-2, 1], [-2, -1]].freeze

  def initialize(parent, pos)
    @pos = pos
    @next_moves = valid_moves_of(pos)
    @parent = parent
  end

  def valid_moves_of(pos, moves = [])
    DIRECTIONS.each do |array|
      new_pos = [array, pos].transpose.map { |x| x.reduce(:+) }
      moves << new_pos if new_pos.all? { |i| i >= 0 && i < 8 }
    end
    moves
  end
end
