require 'pry'
require 'minitest/autorun'
require_relative '../lib/robot'
require_relative '../lib/table'

class RobotTest < Minitest::Test
  def setup
    @table = Table.new
    @robot = Robot.new(position_x: 0, position_y: 0, facing_direction: :north, table: @table)
  end

  def test_move
    @robot.move
    assert_equal '0,1,NORTH', @robot.report
  end

  def test_turn_left
    @robot.left
    assert_equal '0,0,WEST', @robot.report
  end

  def test_turn_right
    @robot.right
    assert_equal '0,0,EAST', @robot.report
  end

  def test_turn_left_and_move
    @robot.left
    @robot.move
    assert_equal '0,0,WEST', @robot.report
  end

  def test_turn_right_and_move
    @robot.right
    @robot.move
    assert_equal '1,0,EAST', @robot.report
  end
end
