class Solution:
    def findTarget(self, root: TreeNode, target: int) -> bool:
        seen = set()

        def dfs(node):
            if not node:
                return False
            if target - node.val in seen:
                return True
            seen.add(node.val)
            return dfs(node.left) or dfs(node.right)

        return dfs(root)