from collections import deque

class CBTInserter:

    def __init__(self, root: TreeNode):
        self.root = root
        self.queue = deque()
        self._build_queue()

    def _build_queue(self):
        self.queue = deque()
        q = deque([self.root])
        while q:
            node = q.popleft()
            if node.left:
                q.append(node.left)
            if node.right:
                q.append(node.right)
            if not node.left or not node.right:
                self.queue.append(node)

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)
        parent = self.queue[0]
        if not parent.left:
            parent.left = new_node
        else:
            parent.right = new_node
            self.queue.popleft()
        self.queue.append(new_node)
        return parent.val

    def get_root(self) -> TreeNode:
        return self.root