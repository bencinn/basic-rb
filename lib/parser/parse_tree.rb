# frozen_string_literal: true

# TODO: Actually decides on the structure of the parse tree
# Thinking of using a tree structure with a root node of type PROGRAM
# branches will be FUNCTION and EXPR
# FUNCTION will have value of IDENT, branches of EXPR (parameter) and EXPR
# EXPR is undecided
class ParseTree
  attr_reader :type, :value, :branches

  def initialize(type, value, branches)
    @type = type
    @value = value
    @branches = branches
  end

  # TODO: Fix this shit
  def parse_tree_to_string
    [@type, @value, *@branches&.map(&:parse_tree_to_string)].compact.join(' ')
  end

  def add_branch(branch)
    @branches << branch
  end
end

module ParseTreeType
  PROG = :program
  FUNCTION = :function
  EXPR = :expr
  RETURN = :return
  VAR_USE = :var_use
  INT = :int
end
