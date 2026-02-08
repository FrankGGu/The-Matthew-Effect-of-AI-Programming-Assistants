from collections import defaultdict, deque
from typing import List, TreeNode

class Solution:
    def verticalOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []

        column_map = defaultdict(list)
        queue = deque([(root, 0)])

        while queue:
            node, col = queue.popleft()
            column_map[col].append(node.val)

            if node.left:
                queue.append((node.left, col - 1))
            if node.right:
                queue.append((node.right, col + 1))

        return [column_map[col] for col in sorted(column_map.keys())]