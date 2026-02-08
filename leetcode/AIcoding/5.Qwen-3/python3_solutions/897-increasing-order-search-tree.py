class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        def dfs(node):
            if not node:
                return None
            left = dfs(node.left)
            right = dfs(node.right)
            node.left = None
            if left:
                left.right = node
            else:
                self.head = node
            node.right = right
            return node

        self.head = None
        dfs(root)
        return self.head