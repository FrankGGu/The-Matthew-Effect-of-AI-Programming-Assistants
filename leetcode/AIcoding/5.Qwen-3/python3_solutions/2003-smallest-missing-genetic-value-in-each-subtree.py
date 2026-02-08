class Solution:
    def smallestMissingAndSubtree(self, root: TreeNode) -> List[int]:
        from collections import defaultdict

        def dfs(node):
            if not node:
                return set()
            left = dfs(node.left)
            right = dfs(node.right)
            res = left.union(right)
            res.add(node.val)
            return res

        result = []
        stack = [root]
        while stack:
            node = stack.pop()
            if node:
                result.append(len(dfs(node)))
                stack.append(node.right)
                stack.append(node.left)
        return result