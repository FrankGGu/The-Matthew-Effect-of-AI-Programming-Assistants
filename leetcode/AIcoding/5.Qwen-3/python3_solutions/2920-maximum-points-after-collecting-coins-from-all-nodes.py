class Solution:
    def maxPoints(self, root: TreeNode) -> int:
        def dfs(node):
            if not node:
                return (0, 0)
            left = dfs(node.left)
            right = dfs(node.right)
            take = node.val + left[1] + right[1]
            not_take = max(left[0], left[1]) + max(right[0], right[1])
            return (take, not_take)

        return max(dfs(root))