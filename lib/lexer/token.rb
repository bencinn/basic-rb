# frozen_string_literal: true

class Token
  attr_reader :token_type
  attr_reader :token_value

  def initialize(type, val)
    @token_type = type
    @token_value = val
  end
end

module TokenType
  INT = :integer
  IDENT = :ident
  SEMIS = :semis

end
