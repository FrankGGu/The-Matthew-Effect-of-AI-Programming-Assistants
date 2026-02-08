class Solution:
    def __init__(self):
        self.inverted = False

    def invertTree(self, root):
        if root is None:
            return None
        root.left, root.right = self.invertTree(root.right), self.invertTree(root.left)
        return root

    def sumOfLeftSubtree(self, root):
        if root is None:
            return 0
        return root.val + self.sumOfLeftSubtree(root.left) + self.sumOfLeftSubtree(root.right)

    def sumOfRightSubtree(self, root):
        if root is None:
            return 0
        return root.val + self.sumOfRightSubtree(root.left) + self.sumOfRightSubtree(root.right)

    def isSubtree(self, s, t):
        if t is None:
            return True
        if s is None:
            return False
        if self.isSameTree(s, t):
            return True
        return self.isSubtree(s.left, t) or self.isSubtree(s.right, t)

    def isSameTree(self, s, t):
        if s is None and t is None:
            return True
        if s is None or t is None:
            return False
        return s.val == t.val and self.isSameTree(s.left, t.left) and self.isSameTree(s.right, t.right)

    def subtreeSum(self, s, t):
        if not self.isSubtree(s, t):
            return 0
        self.inverted = False
        self.invertTree(t)
        self.inverted = True
        return self.sumOfLeftSubtree(s) - self.sumOfRightSubtree(s)