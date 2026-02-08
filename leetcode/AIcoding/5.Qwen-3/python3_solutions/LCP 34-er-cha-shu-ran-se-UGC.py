class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minimumSeconds(self, root: TreeNode) -> int:
        def dfs(node):
            if not node:
                return (0, 0)
            left = dfs(node.left)
            right = dfs(node.right)
            total = left[0] + right[0] + 1
            max_depth = max(left[1], right[1]) + 1
            return (total, max_depth)

        total_nodes, max_depth = dfs(root)
        return max_depth