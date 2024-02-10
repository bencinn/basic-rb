# frozen_string_literal: true

# TODO: Actually decides on the structure of the parse tree
# Thinking of using a tree structure with a root node of type PROGRAM
# branches will be FUNCTION and EXPR
# FUNCTION will have value of IDENT, branches of EXPR (parameter) and EXPR
# EXPR is undecided
class ParseTree
  def initialize(type, value, branches)
    @type = type
    @value = value
    @branches = branches
  end
end

module ParseTreeType
  PROGRAM
  FUNCTION
  EXPR
end