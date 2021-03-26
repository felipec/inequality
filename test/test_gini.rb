#!/usr/bin/env ruby

require 'test/unit'

require_relative '../lib/inequality'

class WGiniTests < Test::Unit::TestCase

  def check(data, expected)
    assert_equal(expected, gini(data).round(6))
  end

  def test_1
    data = [[10, 1], [10, 1]]
    check(data, 0.0)
  end

  def test_2
    data = [[0, 1], [20, 1]]
    check(data, 0.5)
  end

  def test_3
    data = [[1, 4], [16, 1]]
    check(data, 0.6)
  end

  def test_4
    data = [[1, 99], [99, 1]]
    check(data, 0.49)
  end

end
