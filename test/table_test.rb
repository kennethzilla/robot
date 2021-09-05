require 'pry'
require 'minitest/autorun'
require_relative '../lib/robot'
require_relative '../lib/table'

class TableTest < Minitest::Test
  def setup
    @table = Table.new
  end

  def test_in_bounds
    assert @table.in_bounds?(row: 0, column: 0)
  end

  def test_out_bounds_value
    refute @table.in_bounds?(row: 5, column: 0)
  end
end
