class Solution:
    def deepestLeavesSum(self, root: TreeNode) -> int:
        from collections import deque

        if not root:
            return 0

        queue = deque([root])
        sum_last_level = 0

        while queue:
            level_size = len(queue)
            sum_current_level = 0

            for _ in range(level_size):
                node = queue.popleft()
                sum_current_level += node.val

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            sum_last_level = sum_current_level

        return sum_last_level