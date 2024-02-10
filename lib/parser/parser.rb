# frozen_string_literal: true

class Parser
  def initialize(tokens)
    @tokens = tokens
    @pos = 0
  end

  private

  def consume(type, val)
    raise 'Nil token' if @tokens[@pos].nil?
    raise "Expected #{type} but got #{@tokens[@pos].token_type}" unless @tokens[@pos].token_type == type
    raise "Expected #{val} but got #{@tokens[@pos].token_value}" unless val.nil? || (@tokens[@pos].token_value == val)

    # TODO: Add error handling
    @tokens[@pos += 1]
  end

  def parse_func
    consume(:ident, 'func')
    consume(:ident, nil)
    consume(:l_paren, nil)
    consume(:r_paren, nil)
    consume(:l_brace, nil)
  end
end
