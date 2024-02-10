# frozen_string_literal: true

require_relative './parse_tree'

class Parser
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
    consume(:r_brace, nil)
    @tree.add_branch(ParseTree.new(:function, t.token_value, []))
  end
end
