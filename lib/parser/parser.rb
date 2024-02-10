# frozen_string_literal: true

require_relative './parse_tree'

class Parser
  attr_reader :tree

  def initialize(tokens)
    @tokens = tokens
    @pos = 0
    @tree = ParseTree.new(:program, nil, [])
  end

  def parse_all
    while @pos < @tokens.length
      case @tokens[@pos].token_value
      when 'func'
        parse_func
      else
        raise "Unknown token type #{@tokens[@pos]}"
      end
    end
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
    consume(:colon, nil)
    type = ParseTree.new(:ident, consume(:ident, nil).token_value, nil)
    consume(:l_brace, nil)
    stmts_and_types = [type]
    stmts_and_types << parse_stmt while @tokens[@pos].token_type != :r_brace
    consume(:r_brace, nil)
    @tree.add_branch(ParseTree.new(:function, t.token_value, stmts_and_types))
  end

  def calculate_precedence(token)
    case token.token_type
    when :plus, :minus
      1
    when :star, :slash
      2
    when :l_paren
      0
    else
      return nil
    end
  end

  def parse_stmt
    raise "Unknown token type #{@tokens[@pos]}" unless @tokens[@pos].token_type == :ident

    case @tokens[@pos].token_value
    when 'return'
      consume(:ident, 'return')
      return_tree = ParseTree.new(:return, nil, [parse_expr])
      consume(:semis, nil)
      return_tree
    else
      raise "Unknown token type #{@tokens[@pos + 1].token_value}"
    end
  end

  def parse_expr_with_precedence(lhs, precedence)
    return nil if @pos >= @tokens.length

    while @pos < @tokens.length
      op = @tokens[@pos]
      break if op.nil? || calculate_precedence(op).nil? || calculate_precedence(op) < precedence

      @pos += 1
      rhs = parse_primary
      while @pos < @tokens.length
        next_op = @tokens[@pos]
        break if next_op.nil? || calculate_precedence(next_op).nil? || calculate_precedence(next_op) <= precedence

        rhs = parse_expr_with_precedence(rhs, calculate_precedence(next_op))
      end
      lhs = ParseTree.new(op.token_type, nil, [lhs, rhs])
    end
    lhs
  end

  def parse_expr
    primary = parse_primary
    parse_expr_with_precedence(primary, 0) unless primary.nil?
  end

  def parse_primary
    case @tokens[@pos].token_type
    when :integer
      t = consume(:integer, nil)
      ParseTree.new(:int, t.token_value, [])
    when :ident
      t = consume(:ident, nil)
      ParseTree.new(:ident, t.token_value, [])
    when :l_paren
      consume(:l_paren, nil)
      e = parse_expr
      consume(:r_paren, nil)
      e
    else
      return nil
    end
  end
end
