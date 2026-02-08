class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def rootEqualsSumChildren(self, root: TreeNode) -> bool:
        return root.val == (root.left.val if root.left else 0) + (root.right.val if root.right else 0)