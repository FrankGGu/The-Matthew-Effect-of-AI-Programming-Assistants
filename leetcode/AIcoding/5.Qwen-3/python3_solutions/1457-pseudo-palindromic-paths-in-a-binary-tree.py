class Solution:
    def pseudoPalindromicPaths (self, root: TreeNode) -> int:
        def dfs(node, path):
            if not node:
                return 0
            path ^= (1 << node.val)
            if not node.left and not node.right:
                return 1 if path & (path - 1) == 0 else 0
            return dfs(node.left, path) + dfs(node.right, path)
        return dfs(root, 0)