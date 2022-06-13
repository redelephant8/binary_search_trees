class Node
    include Comparable
    attr_accessor :data, :leftChild, :rightChild

    def initialize(data)
        @data = data
        @leftChild = nil
        @rightChild = nil
    end
end

class Tree
    attr_accessor :data, :root
    def initialize(arr)
        @data = arr.uniq.sort
        @root = build_tree(@data)
    end

    def build_tree(arr)
        return if arr.empty?
        middle = (arr.length - 1) / 2
        root = Node.new(arr[middle])
        root.leftChild = build_tree(arr[0...middle])
        root.rightChild = build_tree(arr[(middle+1)..-1])

        return root
    end

    def insert(value, root = @root)
        return if value == root.data
        if value < root.data
            if root.leftChild.nil?
                root.leftChild = Node.new(value)
            else
                insert(value, root.leftChild)
            end
        else
            value > root.data
            if root.rightChild.nil?
                root.rightChild = Node.new(value)
            else
                insert(value, root.rightChild)
            end
        end
    end

    def delete(value, root = @root)
        return if root.nil?
        if value < root.data
            root.leftChild = delete(value, root.leftChild)
        elsif value > root.data
            root.rightChild = delete(value, root.rightChild)
        end

        if root.data == value
            if root.leftChild.nil?
                root = root.rightChild
            elsif root.rightChild.nil?
                root = root.leftChild
            else
                temp = lowest(root.rightChild)
                root.data = temp.data
                root.rightChild = delete(temp.data, root.rightChild)
            end
        end
        return root
    end

    def find(value, root = @root)
        return root if root.nil? 
        if value < root.data
            root = find(value, root.leftChild)
        elsif value > root.data
            root = find(value, root.rightChild)
        elsif root.data == value
            return root
        end
        return root
    end

    def level_order(root = @root)
        arr = []
        queue = [root]
        while queue[0]
            arr.push(queue[0].data)
            queue.push(queue[0].leftChild) if queue[0].leftChild.nil? == false
            queue.push(queue[0].rightChild) if queue[0].rightChild.nil? == false
            queue.shift
        end
        return arr
    end

    def preorder(root = @root, arr=[])
        return if root.nil?
        arr.push(root.data)
        preorder(root.leftChild, arr)
        preorder(root.rightChild, arr)
        arr
    end

    def inorder(root = @root, arr=[])
        return if root.nil?
        inorder(root.leftChild, arr)
        arr.push(root.data)
        inorder(root.rightChild, arr)
        arr
    end

    def postorder(root = @root, arr=[])
        return if root.nil?
        postorder(root.leftChild, arr)
        postorder(root.rightChild, arr)
        arr.push(root.data)
        arr
    end

    def height(root = @root, type=0)
        return arr.push(counter) if root.nil?
        if root.leftChild 
            left = height(root.leftChild)
        else
            left = 0
        end
        if root.rightChild
            right = height(root.rightChild)
        else
            right = 0
        end
        if type == 0
        if left > right
            return left + 1
        else
            return right + 1
        end
    end
    if type == 1
        puts "Right: #{right}"
        puts "Left: #{left}"
        if left > right && left-right <= 1
            return true
        elsif right > left && right-left <= 1
            return true
        elsif right == left
            return true
        else
            return false
        end
    end
    end

    def width(value, root = @root)
        temp = find(value)
        height - height(temp)
    end

    def balanced?(root = @root)
        height(root, 1)
    end

    def rebalance
        arr = inorder
        initialize(arr)
    end


    def lowest(node)
        node = node.leftChild until node.leftChild.nil?
        node
    end


    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.rightChild, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.rightChild
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.leftChild, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.leftChild
      end
end

tree = Tree.new(Array.new(15) {rand(1..100)})
puts tree.balanced?
p tree.preorder
puts ""
p tree.inorder
puts ""
p tree.postorder
puts ""

tree.pretty_print

tree.insert(888)
tree.insert(999)
tree.insert(777)

puts tree.balanced?

tree.pretty_print

tree.rebalance

puts tree.balanced?

p tree.preorder
puts ""
p tree.inorder
puts ""
p tree.postorder
puts ""

tree.pretty_print
