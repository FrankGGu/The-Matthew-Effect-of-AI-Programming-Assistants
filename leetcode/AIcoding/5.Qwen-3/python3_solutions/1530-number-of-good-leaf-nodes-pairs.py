class Solution:
    def countPairs(self, root: TreeNode, distance: int) -> int:
        self.count = 0

        def dfs(node):
            if not node:
                return []
            if not node.left and not node.right:
                return [1]
            left = dfs(node.left)
            right = dfs(node.right)
            for l in left:
                for r in right:
                    if l + r <= distance:
                        self.count += 1
            return [x + 1 for x in left + right]

        dfs(root)
        return self.count