class Solution:
    def findTilt(self, root: TreeNode) -> int:
        def dfs(node):
            if not node:
                return 0
            left_sum = dfs(node.left)
            right_sum = dfs(node.right)
            self.tilt += abs(left_sum - right_sum)
            return left_sum + right_sum + node.val

        self.tilt = 0
        dfs(root)
        return self.tilt