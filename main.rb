# frozen_string_literal: true

require_relative 'lib/board'

board = Board.new
board.knight_moves([0, 0], [7, 7])
