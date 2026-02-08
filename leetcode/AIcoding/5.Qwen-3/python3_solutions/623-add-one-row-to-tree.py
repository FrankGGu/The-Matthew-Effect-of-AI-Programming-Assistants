class Solution:
    def addOneRow(self, root: TreeNode, val: int, depth: int) -> TreeNode:
        if depth == 1:
            new_root = TreeNode(val)
            new_root.left = root
            return new_root

        from collections import deque

        queue = deque([root])
        current_depth = 1

        while queue:
            level_size = len(queue)
            for _ in range(level_size):
                node = queue.popleft()
                if current_depth == depth - 1:
                    left_child = node.left
                    right_child = node.right
                    new_left = TreeNode(val)
                    new_right = TreeNode(val)
                    new_left.left = left_child
                    new_right.right = right_child
                    node.left = new_left
                    node.right = new_right
                else:
                    if node.left:
                        queue.append(node.left)
                    if node.right:
                        queue.append(node.right)
            current_depth += 1

        return root