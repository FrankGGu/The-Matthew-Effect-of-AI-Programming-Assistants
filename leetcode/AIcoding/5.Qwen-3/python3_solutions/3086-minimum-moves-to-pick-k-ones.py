class Solution:
    def minMoves(self, nums: List[int], k: int) -> int:
        positions = [i for i, num in enumerate(nums) if num == 1]
        n = len(positions)
        if k == 1:
            return 0
        res = float('inf')
        for i in range(n - k + 1):
            left = positions[i]
            right = positions[i + k - 1]
            mid = positions[i + (k - 1) // 2]
            moves = 0
            for j in range(i, i + k):
                moves += abs(positions[j] - mid)
            res = min(res, moves)
        return res