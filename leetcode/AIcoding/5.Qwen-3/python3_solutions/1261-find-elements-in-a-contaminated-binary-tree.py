class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class FindElements:

    def __init__(self, root: TreeNode):
        self.contaminated_tree = root
        self.recover_tree()

    def recover_tree(self):
        if self.contaminated_tree:
            self.contaminated_tree.val = 0
            self._recover(self.contaminated_tree)

    def _recover(self, node):
        if node.left:
            node.left.val = 2 * node.val + 1
            self._recover(node.left)
        if node.right:
            node.right.val = 2 * node.val + 2
            self._recover(node.right)

    def find(self, target: int) -> bool:
        return self._find(self.contaminated_tree, target)

    def _find(self, node, target):
        if not node:
            return False
        if node.val == target:
            return True
        return self._find(node.left, target) or self._find(node.right, target)