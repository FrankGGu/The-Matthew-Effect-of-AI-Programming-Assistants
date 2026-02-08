class Solution:
    def updateTree(self, root: TreeNode) -> TreeNode:
        from collections import defaultdict

        level_sum = defaultdict(int)

        def dfs(node, depth):
            if not node:
                return
            level_sum[depth] += node.val
            dfs(node.left, depth + 1)
            dfs(node.right, depth + 1)

        dfs(root, 0)

        def update(node, depth):
            if not node:
                return
            total = level_sum[depth]
            left_val = node.left.val if node.left else 0
            right_val = node.right.val if node.right else 0
            node.val = total - left_val - right_val
            update(node.left, depth + 1)
            update(node.right, depth + 1)

        update(root, 0)
        return root