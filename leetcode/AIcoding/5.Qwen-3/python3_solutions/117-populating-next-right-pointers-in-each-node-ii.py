class Node:
    def __init__(self, val: int = 0, left: 'Node' = None, right: 'Node' = None, next: 'Node' = None):
        self.val = val
        self.left = left
        self.right = right
        self.next = next

class Solution:
    def connect(self, root: 'Node') -> 'Node':
        if not root:
            return root

        level_start = root

        while level_start:
            current = level_start
            next_level_start = None

            while current:
                if current.left:
                    if next_level_start:
                        next_level_start.next = current.left
                    else:
                        next_level_start = current.left

                    current.left.next = current.right

                if current.right:
                    if next_level_start:
                        next_level_start.next = current.right
                    else:
                        next_level_start = current.right

                current = current.next

            level_start = next_level_start

        return root