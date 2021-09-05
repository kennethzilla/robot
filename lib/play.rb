require_relative 'robot'
COMMANDS = %i[place move left right report]

class Play

  attr_reader :robot

  def initialize
    @table = Table.new
    @robot = Robot.new(table: @table)
  end
  
  def console
    loop do
      raw_input_string = gets.chomp
      input_array = raw_input_string&.split(' ')
      command = input_array[0]&.to_sym
      x, y, facing_direction = input_array[1]&.split(',')
      if valid_command?(command: command, data: input_array[1])
        execute(command: command, x: x, y: y, facing: facing_direction)
      end
    end
  end

  def valid_command?(command:, data: nil)
    return false unless COMMANDS.include?(command)
    if command == :place
      return false if data.nil?
        x, y, facing_direction = data.split(',')
       @robot.valid_placement?(x_position: x, y_position: y, direction: facing_direction)
    end
    true
  end

  private

  def execute(command:, x: nil, y: nil, facing: nil)
    if command == :place
      @robot.place(position_x: x, position_y: y, facing_direction: facing)
    else
      @robot.send(command)
    end
  rescue StandardError => e
    puts e.message
  end
end
