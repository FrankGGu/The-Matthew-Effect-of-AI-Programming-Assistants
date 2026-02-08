class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def countNodes(self, root: TreeNode) -> int:
        def get_height(node):
            height = 0
            while node:
                height += 1
                node = node.left
            return height

        def count_nodes(node):
            if not node:
                return 0
            left_height = get_height(node.left)
            right_height = get_height(node.right)
            if left_height == right_height:
                return (1 << left_height) + count_nodes(node.right)
            else:
                return (1 << right_height) + count_nodes(node.left)

        return count_nodes(root)