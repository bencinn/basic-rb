# frozen_string_literal: true

require_relative './lib/lexer/lexer'
l = Lexer.new(File.read('./test.teo'))
l.lex_all
l.tokens.each { |i| puts "#{i.token_type} #{i.token_value}" }
