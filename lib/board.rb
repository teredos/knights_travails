# frozen_string_literal: true

require_relative 'knight'

# Creates a class for the Board, keeping track of all traversed squares, with
# functions to find a Knight's shortest path.
class Board
  def initialize
    @traversed_pairs = []
  end

  def knight_moves(start, finish, queue = [[parent = nil, start]])
    return km_result(queue) if start == finish

    knight = Knight.new(parent, start)
    @traversed_pairs << queue.shift
    knight.next_moves.each do |move|
      queue << [knight.pos, move] unless seen_sqs(queue).include?(move)
    end
    knight_moves(queue[0][1], finish, queue)
  end

  def km_result(queue)
    shortest_path = calc_shortest_path(queue)
    puts "It takes #{shortest_path.length - 2} move(s) to get from " \
         "#{shortest_path[1]} to #{shortest_path[-1]}:"
    km_path(shortest_path)
  end

  def calc_shortest_path(queue)
    arr = [queue[0][0], queue[0][1]]
    until arr[0].nil?
      @traversed_pairs.each do |elem|
        arr.prepend(elem[0]) if elem[1] == arr[0]
      end
    end
    arr
  end

  def km_path(shortest_path)
    shortest_path.each do |sq|
      next if sq.nil?

      chess_sq = sq.dup
      chess_sq[0] = ('a'..'h').to_a[chess_sq[0]]
      chess_sq[1] = chess_sq[1] + 1
      puts "#{sq} / #{chess_sq.join}"
    end
  end

  def seen_sqs(queue)
    trav_squares = @traversed_pairs.map { |elem| elem[1] }
    squares_queue = queue.map { |elem| elem[1] }
    trav_squares + squares_queue
  end
end
