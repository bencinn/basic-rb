# frozen_string_literal: true

require_relative './parse_tree'

class Parser
  attr_reader :tree

  def initialize(tokens)
    @tokens = tokens
    @pos = 0
    @tree = ParseTree.new(:program, nil, [])
  end

  private

  def consume(type, val)
    raise 'Nil token' if @tokens[@pos].nil?
    raise "Expected #{type} but got #{@tokens[@pos].token_type}" unless @tokens[@pos].token_type == type
    raise "Expected #{val} but got #{@tokens[@pos].token_value}" unless val.nil? || (@tokens[@pos].token_value == val)

    # TODO: Add error handling
    @pos += 1
    @tokens[@pos - 1]
  end

  def parse_func
    consume(:ident, 'func')
    t = consume(:ident, nil)
    consume(:l_paren, nil)
    consume(:r_paren, nil)
    consume(:l_brace, nil)
    stmts = []
    stmts << parse_stmt while @tokens[@pos].token_type != :r_brace
    consume(:r_brace, nil)
    @tree.add_branch(ParseTree.new(:function, t.token_value, stmts))
  end

  def calculate_precedence(token)
    case token.token_type
    when :plus, :minus
      1
    when :mult, :div
      2
    when :l_paren
      0
    else
      raise "Unknown token type #{token.token_type}"
    end
  end

  def parse_stmt
    raise "Unknown token type #{@tokens[@pos]}" unless @tokens[@pos].token_type == :ident
    case @tokens[@pos].token_value
    when "return"
      consume(:ident, "return")
      return_tree = ParseTree.new(:return, nil, [parse_expr])
      consume(:semis, nil)
      return_tree
    else
      raise "Unknown token type #{@tokens[@pos + 1].token_value}"
    end
  end

  def parse_expr_with_precedence(lhs, precedence)
    return nil if @pos >= @tokens.length
    ParseTree.new(:expr, nil, [lhs])
  end

  def parse_expr
    parse_expr_with_precedence(parse_primary, 0)
  end

  def parse_primary
    case @tokens[@pos].token_type
    when :integer
      t = consume(:integer, nil)
      ParseTree.new(:int, t.token_value, [])
    else
      raise "Unknown token type #{@tokens[@pos].token_type}"
    end
  end
end
