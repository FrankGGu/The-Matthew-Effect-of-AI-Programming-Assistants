from collections import deque

class Solution:
    def isCompleteTree(self, root: TreeNode) -> bool:
        queue = deque([root])
        null_found = False
        while queue:
            node = queue.popleft()
            if not node:
                null_found = True
                continue
            if null_found:
                return False
            queue.append(node.left)
            queue.append(node.right)
        return True