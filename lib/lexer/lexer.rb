# frozen_string_literal: true

require_relative './token'

SYMBOLS = {
  ';' => :semis,
  '(' => :l_paren,
  ')' => :r_paren,
  '{' => :l_brace,
  '}' => :r_brace,
  ':' => :colon,
  '+' => :plus,
  '-' => :minus,
  '*' => :star,
  '/' => :slash
}.freeze

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
      when ' ', "\n", "\r\n"
        @pos += 1
      when '0'..'9'
        val = []
        while @code[@pos] in '0'..'9'
          val.push(@code[@pos])
          @pos += 1
        end
        @tokens.push(Token.new(:integer, val.join))
      when '(', ')', '{', '}', ':', '+', '-', '*', '/'
        @tokens.push(Token.new(SYMBOLS[@code[@pos]], @code[@pos]))
        @pos += 1
      when 'a'..'z', 'A'..'Z'
        val = []
        while (@code[@pos] in 'a'..'z') || (@code[@pos] in 'A'..'Z')
          val.push(@code[@pos])
          @pos += 1
        end
        @tokens.push(Token.new(:ident, val.join))
      else
        raise "Unknown token #{@code[@pos]}"
      end
    end
  end
end
