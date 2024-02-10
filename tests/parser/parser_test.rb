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
    Parser.new(tokens).send(:parse_func)
  end
end
