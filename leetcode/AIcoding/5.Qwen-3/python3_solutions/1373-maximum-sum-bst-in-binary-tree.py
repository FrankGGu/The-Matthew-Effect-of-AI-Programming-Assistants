class Solution:
    def maxSumBST(self, root: TreeNode) -> int:
        self.max_sum = 0

        def dfs(node):
            if not node:
                return (True, 0, float('inf'), float('-inf'))  # is_bst, sum, min_val, max_val

            left_is_bst, left_sum, left_min, left_max = dfs(node.left)
            right_is_bst, right_sum, right_min, right_max = dfs(node.right)

            if left_is_bst and right_is_bst and left_max < node.val and right_min > node.val:
                current_sum = left_sum + right_sum + node.val
                current_min = min(left_min, node.val)
                current_max = max(right_max, node.val)
                self.max_sum = max(self.max_sum, current_sum)
                return (True, current_sum, current_min, current_max)
            else:
                return (False, 0, 0, 0)

        dfs(root)
        return self.max_sum