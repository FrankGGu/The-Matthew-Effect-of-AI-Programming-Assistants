class Solution:
    def findTheWinner(self, n: int, k: int) -> int:
        def winner(n, k):
            if n == 1:
                return 1
            return (winner(n - 1, k) + k - 1) % n + 1
        return winner(n, k)