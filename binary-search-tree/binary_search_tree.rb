=begin
Write your code for the 'Binary Search Tree' exercise in this file. Make the tests in
`binary_search_tree_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/binary-search-tree` directory.
=end

class BST
  include Enumerable

  def initialize(data_tree=nil)
    if data_tree.nil? || data_tree.size == 0
      @root = nil
      return
    end

    !data_tree.is_a?(Array) && data_tree = [data_tree]
    @root = TNode.new(data_tree[0])
    data_tree[1..-1].each {|pnode| insert_node(@root, @root, TNode.new(pnode))}
    @updated = true
  end

  def left
    @root.left
  end

  def right
    @root.right
  end

  def insert(data)
    insert_node(@root, @root, TNode.new(data))
    @updated = true
    self
  end

  def data
    @root.data
  end

  def each
    # in-order traversal
    if block_given?
      dfs.each {|x| yield(x)}
    else
      dfs.each
    end
  end

  # TODO: search

  # TODO: delete
  
  private

  def insert_node(parent, root, node)
    node.nil? && (return nil)

    ## define a closure
    _insert = ->(parent, root, d=:left) do
      if root.nil?
        d == :left ? parent.left = node : parent.right = node
        return
      end

      if node.data < root.data
        _insert[root, root.left]
      elsif node.data > root.data
        _insert[root, root.right, :right]
      else
        _insert[root, root.left]
      end
    end

    _insert[parent, root]
  end

  def dfs
    # cache the values for quick in-order traversal
    if @in_order.nil? || @updated
      @in_order = []
      @updated = false

      ## define a closure
      _dfs = ->(node) do
        if node.nil?
          return @in_order
        elsif node.leaf?
          @in_order << node.data
        else
          _dfs[node.left]
          @in_order << node.data
          _dfs[node.right]
        end
      end

      _dfs[@root]
    else
      @in_order
    end
  end

end

class TNode
  attr_reader :data
  attr_accessor :right, :left

  def initialize(data, right=nil, left=nil)
    @data = data
    @right = right
    @left = left
  end

  def leaf?
    @left.nil? && @right.nil?
  end

  def to_s
    "data:#{data}, left:#{left}, right:#{right}"
  end
end
