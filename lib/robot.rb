require_relative 'table'
require_relative 'compass'
require 'pry'

class Robot
  attr_reader :facing_direction, :position_x, :position_y, :table, :compass

  def initialize(table:, position_x: nil, position_y: nil, facing_direction: nil)
    @table = table
    @compass = Compass.new
    @position_x = position_x
    @position_y = position_y
    @facing_direction = facing_direction
  end

  def place(position_x: nil, position_y: nil, facing_direction: nil)
    @position_x = position_x
    @position_y = position_y
    @facing_direction = facing_direction
  end

  def move
    desire_position_x, desire_position_y = calculate_move
    return unless movable?(desire_position_x: desire_position_x, desire_position_y: desire_position_y)

    @position_x = desire_position_x
    @position_y = desire_position_y
  end

  def left
    result = @compass.ninety_degrees_left(direction: @facing_direction)
    @facing_direction = result
  end

  def right
    result = @compass.ninety_degrees_right(direction: @facing_direction)
    @facing_direction = result
  end

  def report
    puts "#{@position_x},#{@position_y},#{@facing_direction&.upcase}"
    "#{@position_x},#{@position_y},#{@facing_direction&.upcase}"
  end

  def valid_placement?(x_position:, y_position:, direction:)
    @table.in_bounds?(row: x_position, column: y_position) && @compass.valid_command?(direction: direction)
  end

  private

  def movable?(desire_position_x:, desire_position_y:)
    @table.in_bounds?(row: desire_position_x, column: desire_position_y)
  end

  def calculate_move
    case @facing_direction
    when :north  then [@position_x, @position_y + 1]
    when :east   then [@position_x + 1, @position_y]
    when :south  then [@position_x, @position_y - 1]
    when :west   then [@position_x - 1, @position_y]
    end
  end
end
