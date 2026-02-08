class Solution:
    def minCameraInBinaryTree(self, root: TreeNode) -> int:
        self.result = 0

        def dfs(node):
            if not node:
                return 2
            left = dfs(node.left)
            right = dfs(node.right)
            if left == 0 or right == 0:
                self.result += 1
                return 1
            elif left == 1 or right == 1:
                return 2
            else:
                return 0

        if dfs(root) == 0:
            self.result += 1
        return self.result