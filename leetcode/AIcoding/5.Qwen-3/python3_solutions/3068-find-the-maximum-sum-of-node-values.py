class Solution:
    def maximumSum(self, root: TreeNode) -> int:
        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            return max(left, right) + node.val

        def findMaxPath(node):
            if not node:
                return float('-inf')
            left = dfs(node.left)
            right = dfs(node.right)
            current = node.val + left + right
            left_max = findMaxPath(node.left)
            right_max = findMaxPath(node.right)
            return max(current, left_max, right_max)

        return findMaxPath(root)