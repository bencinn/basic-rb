# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/parser/parser'
require_relative '../../lib/lexer/lexer'

class ParserTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_function_consume
    l = Lexer.new("func a(){}")
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    assert_equal(:program, p.cur_tree.type)
    assert_equal(1, p.cur_tree.branches.length)
    assert_equal(:function, p.cur_tree.branches[0].type)
    assert_equal('a', p.cur_tree.branches[0].value)
  end
  def test_to_string
    l = Lexer.new("func a(){}")
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    assert_equal("program ", p.cur_tree.to_s)
    assert_equal("function a", p.cur_tree.branches[0].to_s)
  end
end
