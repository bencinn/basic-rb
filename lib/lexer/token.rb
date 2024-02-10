# frozen_string_literal: true

class Token
  attr_reader :token_type, :token_value

  def initialize(type, val)
    @token_type = type
    @token_value = val
  end
end

module TokenType
  INT = :integer
  IDENT = :ident
  SEMIS = :semis
  L_PAREN = :l_paren
  R_PAREN = :r_paren
  L_BRACE = :l_brace
  R_BRACE = :r_brace
  COLON = :colon

end
