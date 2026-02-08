class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isValidBST(self, root: TreeNode) -> bool:
        def helper(node, lower, upper):
            if not node:
                return True
            if lower is not None and node.val <= lower:
                return False
            if upper is not None and node.val >= upper:
                return False
            return helper(node.left, lower, node.val) and helper(node.right, node.val, upper)

        return helper(root, None, None)