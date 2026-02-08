class Solution:
    def maximumEarnings(self, n: int, k: int) -> int:
        return (n * (n - 1)) // 2 + (k - n + 1) * (n - 1)