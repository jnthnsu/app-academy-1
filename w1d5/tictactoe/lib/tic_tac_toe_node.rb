require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    us = evaluator
    them = other_mark(evaluator)

    if @board.over?
      @board.winner == them
    else
      if us == next_mover_mark #us
        children.all?{|child| child.losing_node?(us)}
      else
        children.any?{|child| child.losing_node?(us)}
      end
    end
  end

  def winning_node?(evaluator)
    losing_node?(other_mark(evaluator))
  end

  def other_mark mark
    mark == :x ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    @board.rows.each_with_index do |row, i|
      row.each_with_index do |space, j|
        board = @board.dup

        if space.nil?
          board[[i,j]] = @next_mover_mark
          next_mark = other_mark(@next_mover_mark)
          children << TicTacToeNode.new(board, next_mark, [i,j])
        end

      end
    end

    children
  end
end
