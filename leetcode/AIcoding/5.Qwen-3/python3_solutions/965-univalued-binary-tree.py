class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isUnivalTree(self, root: TreeNode) -> bool:
        def dfs(node):
            if not node:
                return True
            if node.left and node.left.val != node.val:
                return False
            if node.right and node.right.val != node.val:
                return False
            return dfs(node.left) and dfs(node.right)
        return dfs(root)