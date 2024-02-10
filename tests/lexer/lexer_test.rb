# frozen_string_literal: true

require 'minitest/autorun'

def helper_multiples(s, token_values)
  l = Lexer.new(s)
  l.lex_all
  assert_equal(token_values.length, l.tokens.length)
  token_values.each_with_index do |val, i|
    assert_equal(val, l.tokens[i].token_value)
  end
end

def helper_single(s, token_value)
  l = Lexer.new(s)
  l.lex_all
  assert_equal(1, l.tokens.length)
  assert_equal(token_value, l.tokens[0].token_value)
end

class LexerTest < Minitest::Test
  def test_lex_identifier
    helper_single('a', 'a')
    helper_single('chinoCute', 'chinoCute')
    helper_multiples('caffeLatte caffeMocha cappuccino', %w[caffeLatte caffeMocha cappuccino])
  end

  def test_lex_integer
    helper_single('1', '1')
    helper_single('123', '123')
    helper_multiples('12 2 3', %w[12 2 3])
  end
end
