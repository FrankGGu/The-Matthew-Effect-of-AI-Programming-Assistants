class Solution:
    def averageOfLevels(self, root: TreeNode) -> List[float]:
        from collections import deque

        result = []
        queue = deque([root])

        while queue:
            level_size = len(queue)
            level_sum = 0
            for _ in range(level_size):
                node = queue.popleft()
                level_sum += node.val
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            result.append(level_sum / level_size)

        return result