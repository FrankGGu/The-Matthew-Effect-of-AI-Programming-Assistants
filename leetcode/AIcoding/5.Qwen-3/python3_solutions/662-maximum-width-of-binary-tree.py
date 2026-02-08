from collections import deque

class Solution:
    def widthOfBinaryTree(self, root: TreeNode) -> int:
        if not root:
            return 0
        max_width = 0
        queue = deque([(root, 0)])
        while queue:
            level_size = len(queue)
            level_start = queue[0][1]
            for _ in range(level_size):
                node, index = queue.popleft()
                if node.left:
                    queue.append((node.left, 2 * index))
                if node.right:
                    queue.append((node.right, 2 * index + 1))
            max_width = max(max_width, index - level_start + 1)
        return max_width