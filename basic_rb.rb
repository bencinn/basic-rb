# frozen_string_literal: true

require_relative './lib/lexer/lexer'
require_relative './lib/parser/parser'
l = Lexer.new(File.read('./test.teo'))
l.lex_all
l.tokens.each { |i| puts "#{i.token_type} #{i.token_value}" }
tokens = l.tokens
p = Parser.new(tokens)
p.parse_all
puts p.tree.parse_tree_to_string
