class Solution:
    def sumEvenGrandparent(self, root: TreeNode) -> int:
        def dfs(node, parent, grand_parent):
            if not node:
                return 0
            total = 0
            if grand_parent and grand_parent.val % 2 == 0:
                total += node.val
            total += dfs(node.left, node, parent)
            total += dfs(node.right, node, parent)
            return total

        return dfs(root, None, None)