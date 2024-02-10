# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/parser/parser'
require_relative '../../lib/lexer/lexer'

class ParserTest < Minitest::Test
  def test_empty_function_consume
    l = Lexer.new('func a(){}')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    assert_equal(:program, p.tree.type)
    refute_nil(p.tree.branches)
    assert_equal('program (function a ())', p.tree.parse_tree_to_string)
  end

  def test_return_function_consume
    l = Lexer.new('
    func a(){
      return 1 + 2;
    }')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    refute_nil(p.tree.branches)
    assert_equal('program (function a (return (plus (int 1 () int 2 ()))))', p.tree.parse_tree_to_string)
  end

  def test_to_string
    l = Lexer.new('func a(){}')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    p.send(:parse_func)
    assert_equal('program (function a ())', p.tree.parse_tree_to_string)
  end

  def test_parse_expr
    l = Lexer.new('1 + 2 * 3 - x')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    assert_equal('plus (int 1 () minus (star (int 2 () int 3 ()) ident x ()))', p.send(:parse_expr).parse_tree_to_string)
  end

  def test_parse_expr_with_paren
    l = Lexer.new('1 + 2 * (3 - x) * y')
    l.lex_all
    tokens = l.tokens
    p = Parser.new(tokens)
    assert_equal('plus (int 1 () star (star (int 2 () minus (int 3 () ident x ())) ident y ()))', p.send(:parse_expr).parse_tree_to_string)
  end
end
