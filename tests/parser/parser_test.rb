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

  def test_empty_function_consume
    l = Lexer.new('func a(){}')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    assert_equal(:program, p.tree.type)
    refute_nil(p.tree.branches)
    assert_equal(1, p.tree.branches.length)
    assert_equal(:function, p.tree.branches[0].type)
    assert_equal('a', p.tree.branches[0].value)
  end

  def test_return_function_consume
    l = Lexer.new('
    func a(){
      return 1;
    }')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    refute_nil(p.tree.branches)
    assert_equal('program  function a return  expr  int 1 ', p.tree.parse_tree_to_string)
  end

  def test_to_string
    l = Lexer.new('func a(){}')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    assert_equal('program  function a ', p.tree.parse_tree_to_string)
  end
end
