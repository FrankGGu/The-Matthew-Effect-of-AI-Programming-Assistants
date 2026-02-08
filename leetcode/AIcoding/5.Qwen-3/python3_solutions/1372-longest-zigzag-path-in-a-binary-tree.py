class Solution:
    def longestZigZag(self, root: TreeNode) -> int:
        self.max_length = 0

        def dfs(node, direction):
            if not node:
                return 0
            left = dfs(node.left, 'left')
            right = dfs(node.right, 'right')
            if direction == 'left':
                return left + 1
            else:
                return right + 1

        def traverse(node):
            if not node:
                return
            self.max_length = max(self.max_length, dfs(node, 'left'), dfs(node, 'right'))
            traverse(node.left)
            traverse(node.right)

        traverse(root)
        return self.max_length