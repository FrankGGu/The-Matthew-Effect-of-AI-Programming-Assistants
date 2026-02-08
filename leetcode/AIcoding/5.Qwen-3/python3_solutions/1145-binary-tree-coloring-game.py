class Solution:
    def btreeGameWinningMatch(self, root: TreeNode, n: int, x: int) -> bool:
        def count(node, target):
            if not node or node.val == target:
                return 0
            return 1 + count(node.left, target) + count(node.right, target)

        left = count(root.left, x)
        right = count(root.right, x)
        return left > n // 2 or right > n // 2