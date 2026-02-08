class Node:
    def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight

class Solution:
    def construct(self, grid: List[List[int]]) all) -> 'Node':
        def build(n, x, y):
            if n == 1:
                return Node(grid[x][y], True, None, None, None, None)
            half = n // 2
            topLeft = build(half, x, y)
            topRight = build(half, x, y + half)
            bottomLeft = build(half, x + half, y)
            bottomRight = build(half, x + half, y + half)
            if topLeft.val == topRight.val == bottomLeft.val == bottomRight.val and topLeft.isLeaf and topRight.isLeaf and bottomLeft.isLeaf and bottomRight.isLeaf:
                return Node(topLeft.val, True, None, None, None, None)
            else:
                return Node(False, False, topLeft, topRight, bottomLeft, bottomRight)
        return build(len(grid), 0, 0)