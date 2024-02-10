# frozen_string_literal: true
require_relative './token'

class Lexer
  attr_reader :tokens

  def initialize(code)
    @code = code.chars
    @pos = 0
    @tokens = []
  end

  def lex_all
    while @code.length > @pos
      case @code[@pos]
      when ';'
        @tokens.push(Token.new(:semis, ';'))
        @pos += 1
      when " ", "\n", "\r\n"
        @pos += 1
      when '0'..'9'
        val = []
        while @code[@pos] in '0'..'9'
          val.push(@code[@pos])
          @pos += 1
        end
        @tokens.push(Token.new(:integer, val.join))
      when '('
        @tokens.push(Token.new(:l_paren, '('))
        @pos += 1
      when ')'
        @tokens.push(Token.new(:r_paren, ')'))
        @pos += 1
      when '{'
        @tokens.push(Token.new(:l_brace, val.join))
        @pos += 1
      when '}'
        @tokens.push(Token.new(:r_brace, val.join))
        @pos += 1
      when ':'
        @tokens.push(Token.new(:colon, val.join))
        @pos += 1
      when 'a'..'z', 'A'..'Z'
        val = []
        while @code[@pos] in 'a'..'z' or @code[@pos] in 'A'..'Z'
          val.push(@code[@pos])
          @pos += 1
        end
        @tokens.push(Token.new(:ident, val.join))
      else
        # TODO: Add error handling
        puts "idk \"#{@code[@pos]}\""
        @pos += 1
      end
    end
  end
end
