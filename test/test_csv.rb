#!/usr/bin/env ruby

require 'test/unit'

require_relative '../lib/csv'
require 'tempfile'

class CSVTests < Test::Unit::TestCase

  def setup
    @file = Tempfile.new('input')
  end

  def test_basic
    File.write(@file, "a,b\na,b\n")
    assert_equal([%w[a b]], csv(@file, %w[a b]).to_a)
  end

  def test_converter
    File.write(@file, "a,b\n1,2\n")
    assert_equal([[1, 2]], csv(@file, %w[a b], :to_i).to_a)
  end

  def test_selected
    File.write(@file, "a,b,c\n1,2,3\n")
    assert_equal([[1, 3]], csv(@file, %w[a c], :to_i).to_a)
  end

  def test_multiple
    File.write(@file, "a,b,c\n1,2,3\n4,5,6\n7,8,9")
    assert_equal([[1, 3], [4, 6], [7, 9]], csv(@file, %w[a c], :to_i).to_a)
  end

end
