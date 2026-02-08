class Solution:
    def numMovesStonesII(self, stones: List[int]) -> int:
        stones.sort()
        n = len(stones)
        if stones[-1] - stones[0] == n - 1:
            return 0
        min_moves = float('inf')
        for i in range(n):
            j = i + 1
            while j < n and stones[j] - stones[i] < n - 1:
                j += 1
            if j < n:
                min_moves = min(min_moves, (stones[j] - stones[i] - (n - 1)) + (j - i - 1))
            else:
                min_moves = min(min_moves, (stones[-1] - stones[i] - (n - 1)) + (n - i - 1))
        return min_moves