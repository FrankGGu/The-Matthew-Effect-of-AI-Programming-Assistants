class Solution:
    def eliminationGame(self, n: int) -> int:
        def helper(n, direction):
            if n == 1:
                return 1
            if direction == 1:
                return 2 * helper(n // 2, -1)
            else:
                return 2 * helper(n // 2, 1) - 1
        return helper(n, 1)