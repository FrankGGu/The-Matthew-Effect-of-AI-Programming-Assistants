class Solution:
    def lcaDeepestLeaves(self, root: TreeNode) -> TreeNode:
        def dfs(node):
            if not node:
                return (None, 0)
            left_lca, left_depth = dfs(node.left)
            right_lca, right_depth = dfs(node.right)
            if left_depth > right_depth:
                return (left_lca, left_depth + 1)
            elif right_depth > left_depth:
                return (right_lca, right_depth + 1)
            else:
                return (node, left_depth + 1)

        lca, _ = dfs(root)
        return lca