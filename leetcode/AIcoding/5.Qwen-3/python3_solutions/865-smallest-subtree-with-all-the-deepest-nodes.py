class Solution:
    def subtreeWithAllDeepest(self, root: TreeNode) -> TreeNode:
        def dfs(node):
            if not node:
                return (None, 0)
            left = dfs(node.left)
            right = dfs(node.right)
            if left[1] > right[1]:
                return (left[0], left[1] + 1)
            elif right[1] > left[1]:
                return (right[0], right[1] + 1)
            else:
                return (node, left[1] + 1)

        return dfs(root)[0]